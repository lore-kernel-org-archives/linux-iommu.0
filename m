From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [iommu:ppc/pamu 1/1] drivers/iommu/fsl_pamu.h:24:32: fatal error:
	asm/fsl_pamu_stash.h: No such file or directory
Date: Tue, 5 May 2015 13:22:24 +0000
Message-ID: <BN1PR0301MB06271FBAE46B4CBDD9781D0FEAD10@BN1PR0301MB0627.namprd03.prod.outlook.com>
References: <201503240804.8vcZXNOY%fengguang.wu@intel.com>
	<551122E2.1040408@Freescale.com>
	<BN3PR0301MB12195D8782612E67CDE2BFD9EA0B0@BN3PR0301MB1219.namprd03.prod.outlook.com>
	<55125179.8040801@Freescale.com>
	<BN3PR0301MB12193C6929AE8CF767B8A78AEA0B0@BN3PR0301MB1219.namprd03.prod.outlook.com>
	<55126585.7040903@Freescale.com>
	<BN3PR0301MB12198F55BD2619F392B58AD4EAFC0@BN3PR0301MB1219.namprd03.prod.outlook.com>
	<20150505131713.GD5438@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150505131713.GD5438-l3A5Bk7waGM@public.gmane.org>
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
To: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Madalin-Cristian Bucur <madalin.bucur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

> -----Original Message-----
> From: jroedel-l3A5Bk7waGM@public.gmane.org [mailto:jroedel-l3A5Bk7waGM@public.gmane.org]
> Sent: Tuesday, May 05, 2015 6:47 PM
> To: Sethi Varun-B16395
> Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Bucur Madalin-
> Cristian-B32716
> Subject: Re: [iommu:ppc/pamu 1/1] drivers/iommu/fsl_pamu.h:24:32: fatal
> error: asm/fsl_pamu_stash.h: No such file or directory
> 
> Hi Varun,
> 
> On Wed, Apr 08, 2015 at 01:24:16PM +0000, Varun Sethi wrote:
> > Following issue was observed while building (compile test) for a
> > non-powerpc (e500mc) based platform. The pamu driver includes a file
> > which is available in the architecture include directory. Should we
> > move the header file to general Linux kernel include directory?
> 
> Before I added the COMPILE_TEST dependency it looked like this:
> 
> 	depends on PPC_E500MC
> 
> Which means the driver was only buildable on e500mc and now you are
> telling me that this is broken. What am I missing?
> 
PPC_E500MC dependency is fine, but with the COMPIL_TEST flag ("or" condition) the PAMU driver code would be built on any platform if the compile test is selected.

-Varun
