From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH] iommu/fsl_pamu: use physical cpu index to find the
	matched cpu nodes
Date: Tue, 19 Nov 2013 02:42:09 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A5B966D@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1384457440.2144.15.camel@haiying-laptop>
	<1384467025.1403.210.camel@snotra.buserror.net>
	<C5ECD7A89D1DC44195F34B25E172658D0A5B0AE8@039-SN2MPN1-012.039d.mgd.msft.net>
	<1384803449.1403.313.camel@snotra.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1384803449.1403.313.camel-88ow+0ZRuxG2UiBs7uKeOtHuzzzSOjJt@public.gmane.org>
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
Cc: "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Haiying Wang <Haiying.Wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

For the DSP case again we have to set up the stash attribute. Are you saying that this should be a separate attribute? 

-Varun

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, November 19, 2013 1:07 AM
> To: Sethi Varun-B16395
> Cc: Wang Haiying-R54964; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> Subject: Re: [PATCH] iommu/fsl_pamu: use physical cpu index to find the
> matched cpu nodes
> 
> On Thu, 2013-11-14 at 21:16 -0600, Sethi Varun-B16395 wrote:
> > Haiying/Scott,
> > Forgot to mention this, the PAMU driver has to handle stash
> > destination settings both for power and dsp cores (on B4 platform).
> > For the dsp cores we would expect the physical core id (not controlled
> by Linux).
> > To make the interface consistent, I would expect the caller (for
> > iommu_set_attr) to pass the physical core id.
> 
> That sounds like you need two different interfaces.
> 
> -Scott
> 
