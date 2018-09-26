From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
Date: Wed, 26 Sep 2018 11:14:05 +0100
Message-ID: <2842c93a-6252-225f-1595-296fe5bbb778@arm.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
 <130edd60-d92a-9871-334b-943fe8acffee@arm.com>
 <20180925151711.7ea1cf75@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925151711.7ea1cf75@jacob-builder>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On 25/09/2018 23:17, Jacob Pan wrote:
> On Tue, 25 Sep 2018 15:58:41 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> Hi Jacob,
>> 
>> Just two minor things below, that I noticed while using fault handlers
>> for SVA. From my perspective the series is fine otherwise
>> 
>> On 11/05/2018 21:54, Jacob Pan wrote:
>> > +int iommu_unregister_device_fault_handler(struct device *dev)
>> > +{
>> > +       struct iommu_param *param = dev->iommu_param;
>> > +       int ret = 0;
>> > +
>> > +       if (!param)
>> > +               return -EINVAL;
>> > +
>> > +       mutex_lock(&param->lock);  
>> 
>> Could we check that param->fault_param isn't NULL here, so that the
>> driver can call this function unconditionally in a cleanup path?
>> 
> sounds good.
> 
>         if (!param || param->fault_param)
>                 return -EINVAL;

That would be too convenient... param needs to be checked before taking
the lock, and fault_param accessed after

Thanks,
Jean
