From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 11/26] iommu/fsl: Fix checkpatch type OOM_MESSAGE
Date: Fri, 30 Jan 2015 14:47:45 +0000
Message-ID: <BN3PR0301MB121951D31A4BE060FC4447A2EA310@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1422455698-3074-1-git-send-email-Emilian.Medve@Freescale.com>
	<1422455698-3074-12-git-send-email-Emilian.Medve@Freescale.com>
	<BN3PR0301MB1219BCCB01E99D150D0753F6EA310@BN3PR0301MB1219.namprd03.prod.outlook.com>
	<54CB92C0.5000304@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54CB92C0.5000304-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
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
To: Emilian Medve <Emilian.Medve-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Emil,

> -----Original Message-----
> From: Emil Medve [mailto:Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org]
> Sent: Friday, January 30, 2015 7:49 PM
> To: Sethi Varun-B16395; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; jroedel-l3A5Bk7waGM@public.gmane.org
> Subject: Re: [PATCH 11/26] iommu/fsl: Fix checkpatch type OOM_MESSAGE
> 
> Hello Varun,
> 
> 
> On 01/30/2015 03:43 AM, Sethi Varun-B16395 wrote:
> > Hi Emil,
> >
> >> -----Original Message-----
> >> From: Emil Medve [mailto:Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org]
> >> Sent: Wednesday, January 28, 2015 8:05 PM
> >> To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
> >> jroedel-l3A5Bk7waGM@public.gmane.org; Sethi Varun-B16395
> >> Cc: Medve Emilian-EMMEDVE1
> >> Subject: [PATCH 11/26] iommu/fsl: Fix checkpatch type OOM_MESSAGE
> >>
> >> WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory'
> message
> >> +       if (!data) {
> >> +               dev_err(&pdev->dev, "PAMU isr data memory allocation
> >> + failed\n");
> >>
> >> Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
> >> ---
> >>  drivers/iommu/fsl_pamu.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> >> index
> >> 4f1926b..6f9c976 100644
> >> --- a/drivers/iommu/fsl_pamu.c
> >> +++ b/drivers/iommu/fsl_pamu.c
> >> @@ -1041,7 +1041,6 @@ static int __init fsl_pamu_probe(struct
> >> platform_device *pdev)
> >>
> >>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
> >>  	if (!data) {
> >> -		dev_err(&pdev->dev, "PAMU isr data memory allocation
> >> failed\n");
> >>  		ret = -ENOMEM;
> >>  		goto error;
> >>  	}
> > I think this is fine, there are other places as well where we have
> > error prints while setting the ENOMEM as the return code.
> 
> This is a checkpatch report and I quote from the log:

Acked-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
 
