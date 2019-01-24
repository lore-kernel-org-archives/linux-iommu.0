From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 2/8] iommu/vt-d: Add per-device IOMMU feature ops
 entries
Date: Thu, 24 Jan 2019 14:47:39 +0800
Message-ID: <b96994da-b3bd-1321-b45f-4c9c1fc4b0c4@linux.intel.com>
References: <20190110030027.31447-1-baolu.lu@linux.intel.com>
 <20190110030027.31447-3-baolu.lu@linux.intel.com>
 <20190111111644.epawu474jdjv4a33@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190111111644.epawu474jdjv4a33@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, Zeng@8bytes.org, Xin <xin.zeng@intel.com>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 1/11/19 7:16 PM, Joerg Roedel wrote:
>> +
>> +static bool
>> +intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
>> +{
>> +	struct device_domain_info *info = dev->archdata.iommu;
>> +
>> +	if (feat == IOMMU_DEV_FEAT_AUX)
>> +		return scalable_mode_support() && info && info->auxd_enabled;
>> +
>> +	return false;
>> +}
> Why is this checking the auxd_enabled flag? The function should just
> return whether the device_supports_  scalable mode, not whether it is
> enabled.

Yes, as the API name implies, it should return the device capability
instead of enable/disable status. I misused this API in the IOMMU
driver.

Since we already have iommu_dev_enable/disable_feature() to enable and
disable an iommu specific feature, is it possible to add another API to
query whether a specific feature has been enabled?

How about

bool iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX)?

This is necessary for the third party drivers (like vfio) to determine
which domain attach interface it should use:

if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
         iommmu_aux_attach_device(domain, dev)
else
         iommu_attach_device(domain, dev)


Best regards,
Lu Baolu
