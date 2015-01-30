From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 00/26] iommu/fsl: Various cleanup
Date: Fri, 30 Jan 2015 14:50:17 +0000
Message-ID: <BN3PR0301MB12194ECBA7501AFE17F34F69EA310@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1422455698-3074-1-git-send-email-Emilian.Medve@Freescale.com>
	<20150130123040.GE3702@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150130123040.GE3702-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Emilian Medve <Emilian.Medve-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

> -----Original Message-----
> From: Joerg Roedel [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
> Sent: Friday, January 30, 2015 6:01 PM
> To: Medve Emilian-EMMEDVE1
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; jroedel-l3A5Bk7waGM@public.gmane.org; Sethi Varun-B16395
> Subject: Re: [PATCH 00/26] iommu/fsl: Various cleanup
> 
> Varun,
> 
> On Wed, Jan 28, 2015 at 08:34:32AM -0600, Emil Medve wrote:
> > Currently a PAMU driver patch is very likely to receive some
> > checkpatch complaints about the code in the context of the patch. This
> > sequence is an attempt to fix most of that and make the dirver more
> > readable
> >
> > Also fixed a subset of the sparse and coccinelle reported issues
> >
> > Emil Medve (26):
> >   iommu/fsl: Sprinkle some __init* annotations
> >   iommu/fsl: Use SVR_* instead of magic numbers
> >   iommu/fsl: Remove unused/extra includes
> >   iommu/fsl: Fix checkpatch type SPACE_BEFORE_TAB
> >   iommu/fsl: Fix checkpatch type LINE_SPACING
> >   iommu/fsl: Fix checkpatch type LEADING_SPACE
> >   iommu/fsl: Fix checkpath type BRACES
> >   iommu/fsl: Fix checkpatch type CODE_INDENT
> >   iommu/fsl: Fix checkpatch type ALLOC_SIZEOF_STRUCT
> >   iommu/fsl: Fix checkpatch type ALLOC_WITH_MULTIPLY
> >   iommu/fsl: Fix checkpatch type OOM_MESSAGE
> >   iommu/fsl: Fix checkpatch type TYPO_SPELLING
> >   iommu/fsl: Fix checkpatch type PREFER_PACKED
> >   iommu/fsl: Fix checkpatch type QUOTED_WHITESPACE_BEFORE_NEWLINE
> >   iommu/fsl: Fix checkpatch type SPACING
> >   iommu/fsl: Use a device pointer to make lines shorter
> >   iommu/fsl: Remove pr/dev_*() prefixes
> >   iommu/fsl: Fix checkpatch type PARENTHESIS_ALIGNMENT
> >   iommu/fsl: Fix some comments alignment
> >   iommu/fsl: Fix alignment of some stray lines
> >   iommu/fsl: Fix checkpatch type LONG_LINE
> >   iommu/fsl: Make local symbols static
> >   iommu/fsl: Use NULL instead of zero
> >   iommu/fsl: Remove unneeded semicolon
> >   iommu/fsl: Don't use integers values with bool type
> >   iommu/fsl: Remove extra paranthesis
> 
> Can you collect the patches you acked and send me a pull-req for them?
> 
Acked, all the patches in the series. Can you apply the series or would you prefer a pull request?

Acked-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
