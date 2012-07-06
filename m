From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 06/28] iommu/amd: Move informational prinks out of
	iommu_enable
Date: Fri, 6 Jul 2012 14:08:24 +0200
Message-ID: <20120706120824.GA2639@amd.com>
References: <1341491808-23083-1-git-send-email-joerg.roedel@amd.com>
	<1341491808-23083-7-git-send-email-joerg.roedel@amd.com>
	<1341547718.27760.5.camel@joe2Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1341547718.27760.5.camel@joe2Laptop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joe,

On Thu, Jul 05, 2012 at 09:08:38PM -0700, Joe Perches wrote:
> On Thu, 2012-07-05 at 14:36 +0200, Joerg Roedel wrote:
> > +	static const char * const feat_str[] = {
> > +		"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
> > +		"IA", "GA", "HE", "PC", NULL
> > +	};
> > +	struct amd_iommu *iommu;
> > +
> > +	for_each_iommu(iommu) {
> > +		int i;
> > +		pr_info("AMD-Vi: Found IOMMU at %s cap 0x%hx\n",
> > +			dev_name(&iommu->dev->dev), iommu->cap_ptr);
> > +		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
> > +			pr_info("AMD-Vi:  Extended features: ");
> > +			for (i = 0; feat_str[i]; ++i)
> > +				if (iommu_feature(iommu, (1ULL << i)))
> > +					pr_cont(" %s", feat_str[i]);
> 
> I think this should use {} around the for loop
> and this would be better as:
> 
> 	static const char * const feat_str[] = {
> 		"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
> 		"IA", "GA", "HE", "PC"
> 	};
> []
> 			for (i = 0; ARRAY_SIZE(feat_str); i++) {
> 				if (iommu_feature(iommu, (1ULL << i)))
> 					pr_cont(" %s", feat_str[i]);
>  			}

Changed that, thanks.

> I don't see the utility of the separate function and
> this could just be inlined in the calling function.

Well, the benefit is that the function call can be easily moved to
another place if necessary. So I left the printks in the seperate
function. The compiler will inline them anyway.

Thanks,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
