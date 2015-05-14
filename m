From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH] iommu/fsl: Fix the dependency check for PAMU driver.
Date: Thu, 14 May 2015 18:17:23 +0000
Message-ID: <BN1PR0301MB06270D8B13522C351C24A63DEAD80@BN1PR0301MB0627.namprd03.prod.outlook.com>
References: <1431625272-17869-1-git-send-email-Varun.Sethi@freescale.com>
	<1431627194.3868.182.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1431627194.3868.182.camel-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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
To: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Scott,

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Thursday, May 14, 2015 11:43 PM
> To: Sethi Varun-B16395
> Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; jroedel-l3A5Bk7waGM@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Subject: Re: [PATCH] iommu/fsl: Fix the dependency check for PAMU driver.
> 
> On Thu, 2015-05-14 at 23:11 +0530, Varun Sethi wrote:
> > Fix the build dependency for the PAMU driver. PPC32 build dependecy is
> incorrect.
> > Add the CORENET_GENERIC build dependency for PAMU driver.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> >  drivers/iommu/Kconfig |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig index
> > 1ae4e54..4ace8db 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -50,7 +50,7 @@ config OF_IOMMU
> >
> >  config FSL_PAMU
> >  	bool "Freescale IOMMU support"
> > -	depends on PPC32
> > +	depends on CORENET_GENERIC
> >  	depends on PPC_E500MC || COMPILE_TEST
> >  	select IOMMU_API
> >  	select GENERIC_ALLOCATOR
> 
> CORENET_GENERIC is for board support.  There is no guarantee that all
> corenet boards will use it.  You already depend on PPC_E500MC; why do you
> need anything else (besides probably getting rid of "|| COMPILE_TEST"
> which is useless if you do add CORENET_GENERIC, because
> CORENET_GENERIC implies PPC_E500MC)?
Yes this is required to counter "||COMPILE_TEST.

-Varun
