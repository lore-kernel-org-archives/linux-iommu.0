From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] IOMMU: arm-smmu-v3: fix broken S2PS and AARCH64 in
	Broadcom Vulcan
Date: Tue, 15 Dec 2015 15:48:35 +0000
Message-ID: <20151215154834.GA11384@arm.com>
References: <1450110687-32207-1-git-send-email-pmallapp@broadcom.com>
	<20151215134010.GH9452@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151215134010.GH9452-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Prem Mallappa <pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 15, 2015 at 01:40:10PM +0000, Will Deacon wrote:
> On Mon, Dec 14, 2015 at 10:01:27PM +0530, Prem Mallappa wrote:
> > @@ -1046,6 +1049,15 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
> >  				      : STRTAB_STE_0_CFG_BYPASS;
> >  		dst[0] = cpu_to_le64(val);
> >  		dst[2] = 0; /* Nuke the VMID */
> > +
> > +		if (smmu && (smmu->options & ARM_SMMU_OPT_BROKEN_STE_VALID)) {
> > +#define SMMU_STE_OAS_44_BITS 0x4UL
> 
> Please don't add a #define here. Can we instead use the oas field that
> we've extracted from IDR5? I think we need to be doing that anyway when
> we're using stage-2 translation, looking at the spec...

... which we already are doing, thanks to the vtcr initialisation in the
io-pgtable code, which populates the PS field based on the OAS.

Will
