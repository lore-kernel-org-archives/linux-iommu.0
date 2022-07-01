Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2366210F3
	for <iommu@lists.linux.dev>; Fri,  1 Jul 2022 03:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656645448; x=1688181448;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X7KG6YEkiVYtWl6cE7h9dCi+akN1ajBggBxEmd4Yg2I=;
  b=CWNWMEsdpv/7XkqYGOQJog5NFjZgZP+wUWXd/PGgOg7qamSHaRiz4P+j
   11SkPw7DEyElCrl3JhSyJ5T7glTjB2BBZE0ocO18emWcJv1BT6geM5U1e
   6KUjOW12aOSfWNUdWEsKmadSOc+SmQYEPn5Mt5nbdOk3pCQyZsmCXmYuj
   zKVcPOdB6077mSwFQCF2tV4cyc19etG5tnw93TZc3QXYp2LdhNcANMb6S
   EOBF7Gz2r4zyaiC04r0I1gUGstAK/i4Dw3+3dl1tE+fQ8If7QS8NGMutH
   uZ4hhYbFUy4DIYyBnjDXeg2TcsW/8Y67XOcNma7+t/Uct182FGfLq9EnA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262940441"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="262940441"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 20:17:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="589066578"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Jun 2022 20:17:24 -0700
Message-ID: <239cfd97-b381-f523-f149-e127f44a0780@linux.intel.com>
Date: Fri, 1 Jul 2022 11:13:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Jerry Snitselaar <jsnitsel@redhat.com>, Mike Travis <mike.travis@hpe.com>,
 Dimitri Sivanich <sivanich@hpe.com>, "Anderson, Russ"
 <russ.anderson@hpe.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/6] iommu/vt-d: Add VTD_FLAG_IOMMU_PROBED flag
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Steve Wahl <steve.wahl@hpe.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
 <20220625125204.2199437-5-baolu.lu@linux.intel.com>
 <BN9PR11MB5276F90888CE86824251E5FC8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F90888CE86824251E5FC8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <20220701031307.8YF9pTASMjOgAgOsLw0Hrj3_j13_c98YSePmdLxsD5Y@z>

On 6/30/22 4:29 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Saturday, June 25, 2022 8:52 PM
>>
>> In the IOMMU hot-add path, there's a need to check whether an IOMMU
>> has been probed. Instead of checking the IOMMU pointer in the global
>> list, it's better to allocate a flag bit in iommu->flags for this
>> purpose.
> 
> Sorry I didn't get the point of original check. This is the hotplug path
> hence the caller of this function should already figure out it's a new
> iommu before reaching this point?
> 

Either did I. It was added by below commit without any comments about
this check.

commit ffebeb46dd34736c90ffbca1ccb0bef8f4827c44
Author: Jiang Liu <jiang.liu@linux.intel.com>
Date:   Sun Nov 9 22:48:02 2014 +0800

     iommu/vt-d: Enhance intel-iommu driver to support DMAR unit hotplug

     Implement required callback functions for intel-iommu driver
     to support DMAR unit hotplug.

     Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
     Reviewed-by: Yijing Wang <wangyijing@huawei.com>
     Signed-off-by: Joerg Roedel <jroedel@suse.de>

I went through the whole hot-add process and found this check seemed to
be duplicate.

Hot-add process starts from dmar_device_hotplug(), it uses a rwlock to
synchronize the hot-add paths.

2386         down_write(&dmar_global_lock);
2387         if (insert)
2388                 ret = dmar_hotplug_insert(tmp);
2389         else
2390                 ret = dmar_hotplug_remove(tmp);
2391         up_write(&dmar_global_lock);

dmar_device_hotplug()
->dmar_hotplug_insert()
-->dmar_parse_one_drhd()   /* the added intel_iommu is allocated here*/
-->dmar_hp_add_drhd()	   /* the intel_iommu is about to bring up */
--->intel_iommu_add()

The duplicate check here:

         if (g_iommus[iommu->seq_id])
                 return 0;

All the iommu units are allocated and then initialized in the same
synchronized path. There is no need to check a duplicate initialization.

I would like to remove this check if no objection.

Best regards,
baolu
