From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [iommu:ppc/pamu 1/1] drivers/iommu/fsl_pamu.h:24:32: fatal error:
	asm/fsl_pamu_stash.h: No such file or directory
Date: Wed, 25 Mar 2015 06:25:09 +0000
Message-ID: <BN3PR0301MB12193C6929AE8CF767B8A78AEA0B0@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <201503240804.8vcZXNOY%fengguang.wu@intel.com>
	<551122E2.1040408@Freescale.com>
	<BN3PR0301MB12195D8782612E67CDE2BFD9EA0B0@BN3PR0301MB1219.namprd03.prod.outlook.com>
	<55125179.8040801@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <55125179.8040801-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
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
To: Emilian Medve <Emilian.Medve-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Emil,

> -----Original Message-----
> From: Emil Medve [mailto:Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org]
> Sent: Wednesday, March 25, 2015 11:41 AM
> To: Sethi Varun-B16395; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; jroedel-l3A5Bk7waGM@public.gmane.org
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Subject: Re: [iommu:ppc/pamu 1/1] drivers/iommu/fsl_pamu.h:24:32: fatal
> error: asm/fsl_pamu_stash.h: No such file or directory
> 
> Hello Varun,
> 
> 
> On 03/25/2015 12:46 AM, Sethi Varun-B16395 wrote:
> >> -----Original Message-----
> >> From: Emil Medve [mailto:Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org]
> >> Sent: Tuesday, March 24, 2015 2:10 PM
> >> To: linuxppc-dev-50dRxjG7WBCY5r8RbUyfqNHuzzzSOjJt@public.gmane.org; Sethi Varun-B16395
> >> Subject: Re: [iommu:ppc/pamu 1/1] drivers/iommu/fsl_pamu.h:24:32:
> >> fatal
> >> error: asm/fsl_pamu_stash.h: No such file or directory
> >>
> >> Hello Varun,
> >>
> >>
> >> On 03/23/2015 07:02 PM, kbuild test robot wrote:
> >>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
> >> ppc/pamu
> >>> head:   f2fafdd954d743a0e68e5cd76dbef2f2454deefa
> >>> commit: f2fafdd954d743a0e68e5cd76dbef2f2454deefa [1/1] iommu/fsl:
> >> PAMU
> >>> is also present on 64-bit SoC(s)
> >>> config: microblaze-allyesconfig (attached as .config)
> >>> reproduce:
> >>>   wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-
> >> tests.git/plain/sbin/make.cross -O ~/bin/make.cross
> >>>   chmod +x ~/bin/make.cross
> >>>   git checkout f2fafdd954d743a0e68e5cd76dbef2f2454deefa
> >>>   # save the attached .config to linux build tree
> >>>   make.cross ARCH=microblaze
> >>>
> >>> All error/warnings:
> >>>
> >>>    In file included from drivers/iommu/fsl_pamu.c:21:0:
> >>>>> drivers/iommu/fsl_pamu.h:24:32: fatal error: asm/fsl_pamu_stash.h:
> >>>>> No such file or directory
> >>>     #include <asm/fsl_pamu_stash.h>
> >>>                                    ^
> >>>    compilation terminated.
> >>>
> >>> vim +24 drivers/iommu/fsl_pamu.h
> >>>
> >>> 695093e3 Varun Sethi 2013-07-15   8   * MERCHANTABILITY or FITNESS
> FOR
> >> A PARTICULAR PURPOSE.  See the
> >>> 695093e3 Varun Sethi 2013-07-15   9   * GNU General Public License for
> >> more details.
> >>> 695093e3 Varun Sethi 2013-07-15  10   *
> >>> 695093e3 Varun Sethi 2013-07-15  11   * You should have received a copy
> of
> >> the GNU General Public License
> >>> 695093e3 Varun Sethi 2013-07-15  12   * along with this program; if not,
> >> write to the Free Software
> >>> 695093e3 Varun Sethi 2013-07-15  13   * Foundation, 51 Franklin Street,
> Fifth
> >> Floor, Boston, MA  02110-1301, USA.
> >>> 695093e3 Varun Sethi 2013-07-15  14   *
> >>> 695093e3 Varun Sethi 2013-07-15  15   * Copyright (C) 2013 Freescale
> >> Semiconductor, Inc.
> >>> 695093e3 Varun Sethi 2013-07-15  16   *
> >>> 695093e3 Varun Sethi 2013-07-15  17   */
> >>> 695093e3 Varun Sethi 2013-07-15  18
> >>> 695093e3 Varun Sethi 2013-07-15  19  #ifndef __FSL_PAMU_H
> >>> 695093e3 Varun Sethi 2013-07-15  20  #define __FSL_PAMU_H
> >>> 695093e3 Varun Sethi 2013-07-15  21
> >>> cd70d465 Emil Medve  2015-01-28  22  #include <linux/iommu.h>
> >>> cd70d465 Emil Medve  2015-01-28  23
> >>> 695093e3 Varun Sethi 2013-07-15 @24  #include
> <asm/fsl_pamu_stash.h>
> >>
> >> The patch just triggered the build and for some reason these folks
> >> are building the driver on non-e500mc arches/defconfigs
> >>
> > Hmm.... I believe PAMU driver got included due to the COMPILE_TEST
> > dependency. This is an issue, if we add the COMPILE_TEST dependency,
> > then we can't include architecture specific include files?
> 
> What in fsl_pamu_stash.h is "even more" arch/platform specific then the
> content of drivers/iommu/fsl_pamu*?
> 
This was discussed during early PAMU driver reviews. Joerg's idea was that PAMU would specific to the Power architecture platform, so we should place the include file in the arch specific directory (originally I had placed it under include/linux). 

-Varun 
