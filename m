From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu: Do physical merging in iommu_map_sg()
Date: Fri, 5 Oct 2018 11:57:57 +0100
Message-ID: <13093b94-be59-030d-7176-16dab22bcdce@arm.com>
References: <1be92cab99ba7fc82cc355bdda239f2ddcb92db0.1538667993.git.robin.murphy@arm.com>
	<20181005071934.GA9238@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181005071934.GA9238-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/10/18 08:19, Christoph Hellwig wrote:
> On Thu, Oct 04, 2018 at 04:47:37PM +0100, Robin Murphy wrote:
>> The original motivation for iommu_map_sg() was to give IOMMU drivers the
>> chance to map an IOVA-contiguous scatterlist as efficiently as they
>> could. It turns out that there isn't really much driver-specific
>> business involved there, so now that the default implementation is
>> mandatory let's just improve that - the main thing we're after is to use
>> larger pages wherever possible, and as long as domain->pgsize_bitmap
>> reflects reality, iommu_map() can already do that in a generic way. All
>> we need to do is detect physically-contiguous segments and batch them
>> into a single map operation, since whatever we do here is transparent to
>> our caller and not bound by any segment-length restrictions on the list
>> itself.
>>
>> Speaking of efficiency, there's really very little point in duplicating
>> the checks that iommu_map() is going to do anyway, so those get cleared
>> up in the process.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> 
> I like the idea, but I find the goto usage to jump back into the just
> terminated loop highly confusing.  Would it be that much worse to simply
> duplicate the iommu_map call?

Yeah, I fiddled around for ages trying to find the cleanest approach, 
but really there just doesn't seem to be one - I'd say the worst bit of 
that goto is the even-more-subtle need for the explicit break. FWIW the 
naive diff below is only actually +2 source lines, but the duplication 
does also carry through to the object code (at least for my arm64 GCC7 
build). I might have a quick hack around to see if I can do any better 
with a do...while loop - of course what I *really* want is nested 
function definitions, but that might just be brain damage from doing too 
much MATLAB in the past ;)

Robin.

----->8-----
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8b22e0502349..4d43146720e9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1686,15 +1686,12 @@ size_t iommu_map_sg(struct iommu_domain *domain, 
unsigned long iova,
  		phys_addr_t s_phys = sg_phys(s);

  		if (len && s_phys != start + len) {
-do_map:
  			ret = iommu_map(domain, iova + mapped, start, len, prot);
  			if (ret)
  				goto out_err;

  			mapped += len;
  			len = 0;
-			if (!s)
-				break;
  		}

  		if (len) {
@@ -1704,8 +1701,13 @@ size_t iommu_map_sg(struct iommu_domain *domain, 
unsigned long iova,
  			start = s_phys;
  		}
  	}
-	if (len)
-		goto do_map;
+	if (len) {
+		ret = iommu_map(domain, iova + mapped, start, len, prot);
+		if (ret)
+			goto out_err;
+
+		mapped += len;
+	}

  	return mapped;
