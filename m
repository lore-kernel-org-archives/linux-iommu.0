From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v2 01/26] iommu/fsl: Sprinkle some __init* annotations
Date: Tue, 10 Feb 2015 02:26:27 +0000
Message-ID: <BY1PR0301MB122186F802612D1B8048722AEA240@BY1PR0301MB1221.namprd03.prod.outlook.com>
References: <1422455698-3074-1-git-send-email-Emilian.Medve@Freescale.com>
	<1422455698-3074-2-git-send-email-Emilian.Medve@Freescale.com>
	<54D92ABC.3030802@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54D92ABC.3030802-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
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
> Sent: Tuesday, February 10, 2015 3:17 AM
> To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; jroedel-l3A5Bk7waGM@public.gmane.org;
> Sethi Varun-B16395
> Subject: Re: [PATCH v2 01/26] iommu/fsl: Sprinkle some __init* annotations
> 
> Hello Joerg,
> 
> 
> On 01/28/2015 08:34 AM, Emil Medve wrote:
> > Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
> > ---
> >  drivers/iommu/fsl_pamu.c        | 12 ++++++------
> >  drivers/iommu/fsl_pamu_domain.c |  2 +-
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> Please don't apply this patch as it's wrong. It's based on
> https://git.kernel.org/cgit/linux/kernel/git/joro/iommu.git/commit/?h=ppc/
> pamu&id=0f1fb99b62ce226f8d818852f812c5d79071ce58
> which is wrong as well and its causing semi-random crashes upon more
> extensive testing. I will follow-up with details shortly
Are you seeing  a crash with https://git.kernel.org/cgit/linux/kernel/git/joro/iommu.git/commit/?h=ppc/pamu&id=0f1fb99b62ce226f8d818852f812c5d79071ce58 ? At, what point do you see crashes?

-Varun
