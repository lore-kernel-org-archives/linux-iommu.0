From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu: add ARM LPAE page table allocator
Date: Tue, 02 Dec 2014 14:41:52 -0800
Message-ID: <vnkw8uipznbj.fsf@mitchelh-linux.qualcomm.com>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
	<1417089078-22900-3-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1417089078-22900-3-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org> (Will
	Deacon's message of "Thu, 27 Nov 2014 11:51:16 +0000")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Robin.Murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 27 2014 at 03:51:16 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> A number of IOMMUs found in ARM SoCs can walk architecture-compatible
> page tables.
>
> This patch adds a generic allocator for Stage-1 and Stage-2 v7/v8
> long-descriptor page tables. 4k, 16k and 64k pages are supported, with
> up to 4-levels of walk to cover a 48-bit address space.
>
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---

[...]

> +static struct io_pgtable *arm_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg,
> +						    void *cookie)
> +{
> +	u64 reg;
> +	struct arm_lpae_io_pgtable *data = arm_lpae_alloc_pgtable(cfg);
> +
> +	if (!data)
> +		return NULL;
> +
> +	/* TCR */
> +	reg = ARM_LPAE_TCR_EAE |
> +	     (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> +	     (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
> +	     (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);

TCR has different definitions depending on whether we're using v7l or
v8l.  For example, bit 31 is TG1[1] (not EAE) when CBA2R.VA64=1.  Are we
expecting to have an io-pgtable-arm64.c or something?  Seems like that
would be mostly redundant with this file...  (We have this problem in
the current arm-smmu driver today).


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
