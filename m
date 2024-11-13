Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDFD2064E9
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530165; cv=none; b=FYbTwg870F3aINtHIKuIJWRqVOvvrmjyPjvdvxAyjVFhmN3aoRhJlhsKy9i4mBlHA2eDczbuogTsOHHTNe9z64Oe6qWiAmgJmX7IEZB4h+0Q+zRPOCFbqfUssVFzq/cUuJwwAo6DWHvmJDCgkV35pXgUy7rLP6HDiOeZ8yiy8Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530165; c=relaxed/simple;
	bh=hzeJYyPVYx6+W1Ui5IIh3935TmNTaZL3dNJoG3qCc+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXCXZtkZyOl4Ivk8aL20tT+sJnuvjWvFO/vdWkWPeO4Xg9+TaDNhpG1doWIdqwG0BcL/kO5vGHzYw+4E2ERw8Y+NabbcduOK9TCL87vAg2K6hEZ0hIKTp6cRPKYTIanKBOhkF9jhMGDCSqj8ohQ+MZ0o8CNXdMOBKkCq0QwuiB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=ND7nYQpn; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="ND7nYQpn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1731530158; bh=hzeJYyPVYx6+W1Ui5IIh3935TmNTaZL3dNJoG3qCc+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ND7nYQpnBB7lHFuoACmVW44KPjqsopcqzrUnoH+H8tujO2iPrMboi85KE+IQpFVHf
	 B1hdZBaQ1jw3M1CrILqEAs6SYl64Dab2uqVrFfatcSDOOetXK0umxznTa1FOpEghTt
	 xOyXZsx1lSuRtn+YDRMu+iGQE4AugENAzkBR8mWwIPummgryvIzWxuxLfx6hB30lm7
	 EkV+2IB7C0xOBSwrOeHOSQBp85n0CXA1QwZkknTjPY/dLndDGpDClur/T43iJKdtTy
	 4PUIYKFQAeHY/5AQzUE1ERgVnXnxmHTYLBPrq4Y6a+S81UG1vaXcUimeLs+IM4oz1w
	 f1db6/G7mv6rUflb4mWIuFly7PrPYnjC0mGN8A1yal7WzuG+4yE1mIOYanq9ZQXIcb
	 jjvga3QEz9T/0F0HtmVygMexYpv9Effm8g3shS/7pRX94yjAogaxe3Cbie2A8a+wAZ
	 qwgc4QlpBVFyD3NR1c6oyAZucYbReiEhrTokVoMaKEuHpZVWrc9+SimWyiB/TGzx9o
	 cutvq55rbQEuReX1PS0aGv7lrwAuZUR03CXZoQ1RFoXY5NhMacp91Fb01Fefza7ICn
	 6pa1Qyn26WWC63u+RKp/hlTUrjeyL+zudaZUzyh3idfM1eVCz7hR6VR3FRilbT1mTA
	 h/wDPaTlKt0BLpw5W4zZV5Zk=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 9895E18DF54;
	Wed, 13 Nov 2024 21:35:57 +0100 (CET)
Message-ID: <e17818c2-8856-47d1-95fe-036b6a4849d6@ijzerbout.nl>
Date: Wed, 13 Nov 2024 21:35:53 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATH v5 2/3] iommu/vt-d: debugfs: Create/remove debugfs file per
 {device, pasid}
To: Baolu Lu <baolu.lu@linux.intel.com>, Jingqi Liu <Jingqi.liu@intel.com>,
 iommu@lists.linux.dev, Tian Kevin <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org
References: <20231013135811.73953-1-Jingqi.liu@intel.com>
 <20231013135811.73953-3-Jingqi.liu@intel.com>
 <2590cecf-e1f9-4af9-8fbb-9b49f5e335c0@ijzerbout.nl>
 <16b3fdb5-6f7b-4728-873c-4047ea69aef5@linux.intel.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <16b3fdb5-6f7b-4728-873c-4047ea69aef5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 13-11-2024 om 03:13 schreef Baolu Lu:
> On 11/13/24 05:22, Kees Bakker wrote:
>> Op 13-10-2023 om 15:58 schreef Jingqi Liu:
>>> Add a debugfs directory per pair of {device, pasid} if the mappings of
>>> its page table are created and destroyed by the iommu_map/unmap()
>>> interfaces. i.e. /sys/kernel/debug/iommu/intel/<device source id>/ 
>>> <pasid>.
>>> Create a debugfs file in the directory for users to dump the page
>>> table corresponding to {device, pasid}. e.g.
>>> /sys/kernel/debug/iommu/intel/0000:00:02.0/1/domain_translation_struct.
>>> For the default domain without pasid, it creates a debugfs file in the
>>> debugfs device directory for users to dump its page table. e.g.
>>> /sys/kernel/debug/iommu/intel/0000:00:02.0/domain_translation_struct.
>>>
>>> When setting a domain to a PASID of device, create a debugfs file in
>>> the pasid debugfs directory for users to dump the page table of the
>>> specified pasid. Remove the debugfs device directory of the device
>>> when releasing a device. e.g.
>>> /sys/kernel/debug/iommu/intel/0000:00:01.0
>>>
>>> Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
>>> ---
>>>   drivers/iommu/intel/debugfs.c | 53 
>>> +++++++++++++++++++++++++++++++----
>>>   drivers/iommu/intel/iommu.c   |  7 +++++
>>>   drivers/iommu/intel/iommu.h   | 14 +++++++++
>>>   3 files changed, 69 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/ 
>>> debugfs.c
>>> [...]
>>> +/* Remove the device pasid debugfs directory. */
>>> +void intel_iommu_debugfs_remove_dev_pasid(struct dev_pasid_info 
>>> *dev_pasid)
>>> +{
>>> +    debugfs_remove_recursive(dev_pasid->debugfs_dentry);
>>> +}
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> [...]
>>> @@ -4710,6 +4713,7 @@ static void 
>>> intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>>>       spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>>       domain_detach_iommu(dmar_domain, iommu);
>>> +    intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>>>       kfree(dev_pasid);
>>>   out_tear_down:
>>>       intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>>>
>>
>> So, a call to intel_iommu_debugfs_remove_dev_pasid() was added.
>> There is a potential problem that dev_pasid can be NULL.
>> The diff doesn't show the whole context so let me give that here.
>> Today that piece of the code looks like this
>>
>>          list_for_each_entry(curr, &dmar_domain->dev_pasids, 
>> link_domain) {
>>                  if (curr->dev == dev && curr->pasid == pasid) {
>>                          list_del(&curr->link_domain);
>>                          dev_pasid = curr;
>>                          break;
>>                  }
>>          }
>>          WARN_ON_ONCE(!dev_pasid);
>>          spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>
>>          cache_tag_unassign_domain(dmar_domain, dev, pasid);
>>          domain_detach_iommu(dmar_domain, iommu);
>>          intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>>          kfree(dev_pasid);
>>
>> The for_each loop can exit without finding an entry.
>> The WARN_ON_ONCE also suggests that there can be a NULL.
>> After that the new function is called (see above) and it will
>> dereference the NULL pointer.
>>
>> Can you have a closer look?
>
> It's already a kernel bug if dev_pasid is NULL when it reaches here. If
> that happens, we should fix the bug, not avoid using the NULL pointer.

How about moving the WARN_ON_ONCE down a bit and use its return value?
Like so

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 527f6f89d8a1..204873976ef3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4096,13 +4096,14 @@ void domain_remove_dev_pasid(struct iommu_domain 
*domain,
                         break;
                 }
         }
-       WARN_ON_ONCE(!dev_pasid);
         spin_unlock_irqrestore(&dmar_domain->lock, flags);

         cache_tag_unassign_domain(dmar_domain, dev, pasid);
         domain_detach_iommu(dmar_domain, iommu);
-       intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
-       kfree(dev_pasid);
+       if (!WARN_ON_ONCE(!dev_pasid)) {
+               intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
+               kfree(dev_pasid);
+       }
  }

  static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t 
pasid,


Would you accept a patch like that? Or do you want to change it yourself?
-- 
Kees
