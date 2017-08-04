From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v9 06/13] iommu/amd: copy old trans table from old kernel
Date: Fri, 4 Aug 2017 21:09:29 +0800
Message-ID: <20170804130929.GN1874@x1>
References: <1501587449-9817-1-git-send-email-bhe@redhat.com>
 <1501587449-9817-7-git-send-email-bhe@redhat.com>
 <20170804122116.GU3431@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170804122116.GU3431@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 08/04/17 at 02:21pm, Joerg Roedel wrote:
> On Tue, Aug 01, 2017 at 07:37:22PM +0800, Baoquan He wrote:
> >  static void init_device_table_dma(void)
> >  {
> > @@ -2137,9 +2140,49 @@ static void early_enable_iommu(struct amd_iommu *iommu)
> >  static void early_enable_iommus(void)
> >  {
> >  	struct amd_iommu *iommu;
> > +	bool is_pre_disabled = false;
> >  
> > -	for_each_iommu(iommu)
> > -		early_enable_iommu(iommu);
> > +	for_each_iommu(iommu) {
> > +		if (!translation_pre_enabled(iommu)) {
> > +			is_pre_disabled = true;
> > +			break;
> > +		}
> > +	}
> 
> I think this could be easier if you make 'is_pre_disabled' a global state
> bool variable with reversed meaning and initialize it with 'true'.
> Basically
> 
> 	static bool __init amd_iommu_pre_enabled = true;
> 
> And set this variable to 'false' when you find a already disabled IOMMU
> during initialization. Then you can remove the code above.

Great idea, will change as you suggested. Thanks.

> 
> > +
> > +	if (is_pre_disabled) {
> > +		for_each_iommu(iommu)
> > +			early_enable_iommu(iommu);
> 
> 		return
> 	}
> 
> > +	} else {
> 
> And remove this to get rid of one indendation level for the code below.
> 
> > +		pr_warn("Translation is already enabled - trying to copy translation structures\n");
> > +		if (copy_device_table()) {
> 
> Seeing how the return value of copy_device_table() is used, it makes
> sense to change its return-type to bool. This way it is also easier to
> see which one is the sucess and which one the failure case.
> 
