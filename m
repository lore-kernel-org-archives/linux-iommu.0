From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: remove homebrew PCI dma alias parsing
Date: Mon, 19 Jan 2015 14:09:48 +0000
Message-ID: <20150119140948.GK32131@arm.com>
References: <1421427514-16579-1-git-send-email-will.deacon@arm.com>
	<1421427514-16579-3-git-send-email-will.deacon@arm.com>
	<BN3PR0301MB121948FC05425680C6C2CA63EA4A0@BN3PR0301MB1219.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BN3PR0301MB121948FC05425680C6C2CA63EA4A0-CEkquS/Gb81uuip9JPHoc5wN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "m-karicheri2-l0cyMroinI0@public.gmane.org" <m-karicheri2-l0cyMroinI0@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 19, 2015 at 01:43:51PM +0000, Varun Sethi wrote:
> Hi Will,

Hey Varun,

> >  		/*
> >  		 * Assume Stream ID == Requester ID for now.
> >  		 * We need a way to describe the ID mappings in FDT.
> >  		 */
> > -		pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid,
> > -				       &cfg->streamids[0]);
> > -		releasefn = __arm_smmu_release_pci_iommudata;
> > +		cfg->streamids[cfg->num_streamids++] = sid;
> 
> [varun] Couldn't there be an issue, when a single stream id is shared by
> multiple devices  (in case of non transparent bridge). Wouldn't that be an
> issue here? When devices are attached to the domain SMR would be allocated
> per stream id, this could lead to duplicate stream ids.

Yup. Since I'm reworking this code after Alex's feedback, I'll add some
code to check for duplicates before adding the new SID.

Thanks,

Will
