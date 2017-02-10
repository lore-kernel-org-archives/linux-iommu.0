From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 06/11] iommu: Add iommu_device_set_fwnode() interface
Date: Fri, 10 Feb 2017 16:59:43 +0000
Message-ID: <af8ef45f-d8e4-41a6-0ff6-88d60864075c@arm.com>
References: <1486639981-32368-1-git-send-email-joro@8bytes.org>
	<1486639981-32368-7-git-send-email-joro@8bytes.org>
	<417eee8c-4e1b-57f0-2c00-d6c3926ce66d@arm.com>
	<20170210152254.GI7339@8bytes.org>
	<f770249b-ad98-10d8-ea79-dc10cef7f4df@arm.com>
	<20170210161122.GB18474@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170210161122.GB18474-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/02/17 16:11, Joerg Roedel wrote:
> On Fri, Feb 10, 2017 at 04:03:07PM +0000, Robin Murphy wrote:
>> Yeah, on reflection explicit initialisation is certainly easier to read
>> than a bunch of arguments handled implicitly by register(), but then
>> from that angle, even more clear would be to simply have the drivers
>> write the relevant struct members directly - I'd be quite happy with
>> that, and we then don't have to add another setter to iommu.h for every
>> new struct member (and risk it looking like Java code...)
> 
> Yeah, that was my first approach. But there is the Intel VT-d anomaly,
> where a part of the driver can be built-in (dmar.c) with
> CONFIG_IOMMU_API=N. In this case 'struct iommu_device' is empty, and
> trying to access the members directly doesn't compile anymore.
> 
> I have to look if this anomaly could be removed, then it is probably the
> best to set the struct members directly without wrapper functions.

Ah, I hadn't managed to spot that - I assume there probably is some
valid edge case for wanting x2APIC functionality without DMA remapping
which prevents us from just adding the dependency. Looking at the code,
though, that situation does seem to rely on the call never actually
executing at runtime - not only is it conditional on a static variable
which is only ever set by non-present code, it would fail the probe if
it were called - so I think it would be perfectly reasonable to just
address that particular problem as below (untested, but if it lets us
get rid of the dummy !IOMMU_API definitions of the registration
functions I'd say we've done the right thing).

Robin.

----->8-----
diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 8ccbd7023194..161641caff79 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1077,6 +1077,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)

        raw_spin_lock_init(&iommu->register_lock);

+#ifdef CONFIG_IOMMU_API
        if (intel_iommu_enabled) {
                iommu->iommu_dev = iommu_device_create(NULL, iommu,
                                                       intel_iommu_groups,
@@ -1087,6 +1088,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
                        goto err_unmap;
                }
        }
+#endif

        drhd->iommu = iommu;
