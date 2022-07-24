Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A5F7E
	for <iommu@lists.linux.dev>; Sun, 24 Jul 2022 07:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658647406; x=1690183406;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W/ZfiGZet5U/LoLWUKDc9YKyt+TrQHvH31tE+Q6WVVY=;
  b=cZpTM0vDkKrrE7Dbdfc1gDO7aPGMxd5f0NPN8p0WO55/o1XMc9Qgp4IJ
   WtyUxZIq5eY3HMKswKcX747tMWsU3XL9T5+HcSXhvbpL/0OsM78JqaXNf
   ZwVY+6cfPqdKDb0HjAZJ5RWS9NZ+/Z8rBjprsnAMa4dEs2RPjqtddrc9u
   Az3gp8kIB8dfej3jtuigpU6eNR+okoA3XBJ7u/oatH6IGfJ8SpTRkRf3+
   e6+h1QWIJJH/gbWSFdeubAVKp2TNBx+Ilddl4JclCm9n0BtcMNyMtUOtI
   q6aYoWJriy6XzbV83tRdo8lEKwuijYn44OZ5DF018AtZNROG9nEnwMfaZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="285070723"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="285070723"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 00:23:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="657737876"
Received: from zjiang1-mobl.ccr.corp.intel.com (HELO [10.249.170.155]) ([10.249.170.155])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 00:23:21 -0700
Message-ID: <5f845a90-97ba-e994-c8b9-91fc6f3ea1c1@linux.intel.com>
Date: Sun, 24 Jul 2022 15:23:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhu Tony <tony.zhu@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220723141118.GD79279@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/7/23 22:11, Jason Gunthorpe wrote:
>> +
>> +	/*
>> +	 * Otherwise, the device came from DT/ACPI, assume it is static and
>> +	 * then singleton can know from the device count in the group.
>> +	 */
>> +	return true;
>> +}
> I would be happer if probe was changed to refuse to add a device to a
> group if the group's pasid xarray is not empty, as a protective
> measure.

Agreed. I will add below code.

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 047898666b9f..e43cb6776087 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -895,6 +895,14 @@ int iommu_group_add_device(struct iommu_group 
*group, struct device *dev)
         int ret, i = 0;
         struct group_device *device;

+       /*
+        * The iommu_attach_device_pasid() requires a singleton group.
+        * Refuse to add a device into it if this assumption has been
+        * made.
+        */
+       if (!xa_empty(group->pasid_array))
+               return -EBUSY;
+
         device = kzalloc(sizeof(*device), GFP_KERNEL);
         if (!device)
                 return -ENOMEM;

> 
>> +int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
>> +			      ioasid_t pasid)
>> +{
>> +	struct iommu_group *group;
>> +	void *curr;
>> +	int ret;
>> +
>> +	if (!domain->ops->set_dev_pasid)
>> +		return -EOPNOTSUPP;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group || !iommu_group_immutable_singleton(group, dev)) {
>> +		iommu_group_put(group);
>> +		return -EINVAL;
> goto error below
> 
>> +	}
>> +
>> +	mutex_lock(&group->mutex);
> Just hold the group->mutex a few lines above and don't put locking in
> iommu_group_immutable_singleton(), it is clearer

Above two comments agreed. iommu_attach_device_pasid() looks like below
after update.

int iommu_attach_device_pasid(struct iommu_domain *domain, struct device 
*dev,
                               ioasid_t pasid)
{
         struct iommu_group *group;
         int ret = -EINVAL;
         void *curr;

         if (!domain->ops->set_dev_pasid)
                 return -EOPNOTSUPP;

         group = iommu_group_get(dev);
         if (!group)
                 return -ENODEV;

         mutex_lock(&group->mutex);
         if (!iommu_group_immutable_singleton(group, dev))
                 goto out_unlock;

         curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, 
GFP_KERNEL);
         if (curr) {
                 ret = xa_err(curr) ? : -EBUSY;
                 goto out_unlock;
         }
         ret = domain->ops->set_dev_pasid(domain, dev, pasid);
         if (ret)
                 xa_erase(&group->pasid_array, pasid);
out_unlock:
         mutex_unlock(&group->mutex);
         iommu_group_put(group);

         return ret;
}

Best regards,
baolu

