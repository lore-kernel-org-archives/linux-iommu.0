From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/4 v4] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Mon, 5 Nov 2012 17:11:15 -0600
Message-ID: <1352157075.28279.10@snotra>
References: <1352114361-25192-1-git-send-email-Varun.Sethi@freescale.com>
	<1352114361-25192-2-git-send-email-Varun.Sethi@freescale.com>
	<1352114361-25192-3-git-send-email-Varun.Sethi@freescale.com>
	<1352114361-25192-4-git-send-email-Varun.Sethi@freescale.com>
	<509845ED.2060904@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <509845ED.2060904@freescale.com> (from timur@freescale.com on
	Mon Nov  5 17:04:13 2012)
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
Cc: Varun Sethi <Varun.Sethi@freescale.com>, joerg.roedel@amd.com, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 11/05/2012 05:04:13 PM, Timur Tabi wrote:
> Varun Sethi wrote:
> > +	/* PAACE Offset 0x00 */
> > +	u32 wbah;				/* only valid for  
> Primary PAACE */
> > +	u32 addr_bitfields;		/* See P/S PAACE_AF_* */
> > +
> > +	/* PAACE Offset 0x08 */
> > +	/* Interpretation of first 32 bits dependent on DD above */
> > +	union {
> > +		struct {
> > +			/* Destination ID, see PAACE_DID_* defines */
> > +			u8 did;
> > +			/* Partition ID */
> > +			u8 pid;
> > +			/* Snoop ID */
> > +			u8 snpid;
> > +			/* coherency_required : 1 reserved : 7 */
> 
> Please use this format, which is easier to read:
> 
> 			/* 1 == coherency required, 7 == reserved */
> 
> Every time I look at this comment, I think you are using bitfields.

It is meant as a pseudo-bitfield.  "7 == reserved" doesn't make much  
sense -- that would leave a lot of other values neither defined nor  
explicitly reserved.

That said, the "See PAACE_DA_*" comment should be sufficient and avoids  
making people have to care about what bitfield ordering the comment  
writer was assuming.

-Scott
