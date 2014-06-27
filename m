From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 04/10] memory: Add Tegra124 memory controller support
Date: Fri, 27 Jun 2014 11:24:59 +0300
Message-ID: <87mwcy4v50.fsf@nvidia.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
	<1403815790-8548-5-git-send-email-thierry.reding@gmail.com>
	<53AD2020.1050802@nvidia.com> <20140627081659.GA10794@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140627081659.GA10794@ulmo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Allen Martin <AMartin-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> * PGP Signed by an unknown key
>
> On Fri, Jun 27, 2014 at 03:41:20PM +0800, Joseph Lo wrote:
>> Hi Thierry,
>> 
>> On 06/27/2014 04:49 AM, Thierry Reding wrote:
>> [snip]
>> >+
>> >+#define MC_INTSTATUS 0x000
>> >+#define  MC_INT_DECERR_MTS (1 << 16)
>> >+#define  MC_INT_SECERR_SEC (1 << 13)
>> >+#define  MC_INT_DECERR_VPR (1 << 12)
>> >+#define  MC_INT_INVALID_APB_ASID_UPDATE (1 << 11)
>> >+#define  MC_INT_INVALID_SMMU_PAGE (1 << 10)
>> >+#define  MC_INT_ARBITRATION_EMEM (1 << 9)
>> >+#define  MC_INT_SECURITY_VIOLATION (1 << 8)
>> >+#define  MC_INT_DECERR_EMEM (1 << 6)
>> >+#define MC_INTMASK 0x004
>> >+#define MC_ERR_STATUS 0x08
>> >+#define MC_ERR_ADR 0x0c
>> >+
>> [snip]
>> >+
>> >+#define SMMU_PDE_ATTR          (SMMU_PDE_READABLE | SMMU_PDE_WRITABLE | \
>> >+                                SMMU_PDE_NONSECURE)
>> >+#define SMMU_PTE_ATTR          (SMMU_PTE_READABLE | SMMU_PTE_WRITABLE | \
>> >+                                SMMU_PTE_NONSECURE)
>> >+
>> >+#define SMMU_PDE_VACANT(n)     (((n) << 10) | SMMU_PDE_ATTR)
>> >+#define SMMU_PTE_VACANT(n)     (((n) << 12) | SMMU_PTE_ATTR)

They should be set 0.

The above VACANT macros are legacy support for some special case that a
device wanted linear SMMU mapping where iova == phy. No need any more.

>> There is an ISR to catch the invalid SMMU translation. Do you want to modify
>> the identity mapping with read/write attribute of the unused SMMU pages?
>
> I'm not sure I understand what you mean by "identity mapping". None of
> the public documentation seems to describe the exact layout of PDEs or
> PTEs, so it's somewhat hard to tell what to set them to when pages are
> unmapped.
>
>> This can make sure we capture the invalid SMMU translation. And helps for
>> driver to capture issues when using SMMU.
>
> That certainly sounds like a useful thing to have. Like I said this is
> an RFC and I'm not even sure if it's acceptable in the current form, so
> I wanted to get feedback early on to avoid wasting effort on something
> that turn out to be a wild-goose chase.
>
> Thierry
>
> * Unknown Key
> * 0x7F3EB3A1
