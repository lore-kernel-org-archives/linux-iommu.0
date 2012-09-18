From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] intel-iommu: Default to non-coherent for domains
	unattached to iommus
Date: Tue, 18 Sep 2012 09:57:58 -0400
Message-ID: <50587DE6.3000207@redhat.com>
References: <1347479705-33972-1-git-send-email-ddutile@redhat.com>
	<20120918115937.GB9939@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120918115937.GB9939-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 09/18/2012 07:59 AM, Joerg Roedel wrote:
> On Wed, Sep 12, 2012 at 03:55:05PM -0400, Donald Dutile wrote:
>> This patch was posted back in Nov 2011:
>>    http://lists.linuxfoundation.org/pipermail/iommu/2011-November/003086.html
>>
>> and due to discussion about the patch, it was never pulled in.
>> Although the thread discussed an alternate patch to
>> default to non-coherent if any IOMMU didn't support coherency,
>> this alternate method was never implemented, and this bug persists.
>>
>> This patch has been in RHEL6 for quite some time,
>> and it wasn't noticed that it didn't get into linux upstream,
>> until a RH partner reported this error when running upstream kernels,
>> and noticed how it doesn't occur on RHEL6 kernels.
>> Applying this patch to an upstream kernel resolved this issue.
>>
>>
>>   domain_update_iommu_coherency() currently defaults to setting
>>   domains as coherent when the domain is not attached to any iommus.
>>   This allows for a window in domain_context_mapping_one() where such a
>>   domain can update context entries non-coherently, and only after
>>   update the domain capability to clear iommu_coherency.
>>   This can be seen using KVM device assignment on VT-d systems that
>>   do not support coherency in the ecap register.  When a device is
>>   added to a guest, a domain is created (iommu_coherency = 0), the
>>   device is attached, and ranges are mapped.  If we then hot unplug
>>   the device, the coherency is updated and set to the default (1)
>>   since no iommus are attached to the domain.  A subsequent attach
>>   of a device makes use of the same dmar domain (now marked coherent)
>>   updates context entries with coherency enabled, and only disables
>>   coherency as the last step in the process.
>>   To fix this, switch domain_update_iommu_coherency() to use the
>>   safer, non-coherent default for domains not attached to iommus.
>>
>> Signed-off-by: Donald Dutile<ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> cc: Alex Williamson<alex.williamson at redhat.com>
>
> Hmm, who is the author? The patch looks the same as what Alex submitted
> last year. I applied Alex' patch because it includes also the Acked-bys
> and he seems to be the author anyway. Oh, and I added a stable-tag.
>
>
> 	Joerg
>
>
Yes, Alex was the original author, thus the reason I cc'd him on the update.

And you can't apply Alex's original patch as-is, since the iommu_bmp
structure element changed from a ptr to an array,
(a snippet of) alex's patch looked like:
+    i = find_first_bit(&domain->iommu_bmp, g_num_of_iommus);

and the correct patch with the change to iommu_bmp is:
+    i = find_first_bit(domain->iommu_bmp, g_num_of_iommus);

and the reason why I re-posted it, vs fwd-ing the original patch
& asking for inclusion.
Additionally, the above patch is what the customer tested & verified.

So, if you made the above adjustment to Alex's patch,
then the patch is ok.  If not, the above adjustment must be made.

- Don
