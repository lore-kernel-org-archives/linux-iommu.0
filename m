Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1A7373
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 02:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689303068; x=1720839068;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3ItH7GDLekgA6ZJq1QFTHSD2GE2/QqQMe4ZG5EQNPz4=;
  b=B7kxvUpNqCnMPYZh0/Felaj0nkOCgQPIEu1sbsg9nrXPosYx0ZCt+FDb
   mRNiIudVbXUCB+1PPFKdRG4oPGxzOyNJlgS8ZTmd4x3O7CMFnyBSg/OUY
   AivItdZIGPpDp9pspzZ11+XQNS7ohGaCsV2ou7K9p4ufygbSdTaYZBe2g
   ZA+Yogs+8xJtJIsPbnOnTwurrSfnp4psFxnUpMp/g5F6hkXIwvF+Dw0lZ
   fOJnCn9CCh+2b1Z2DkL/NXzez6f0KU/0mNuqZXkE8AhATcooYHlf4uMWw
   /1Y1K79DaLb8xxfbL/OnnNrXAMSAvPvaPOdlSvB7W4n+eltpE0tprS0YW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="362837725"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="362837725"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 19:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="716174394"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="716174394"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.49]) ([10.252.191.49])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 19:51:01 -0700
Message-ID: <ed4200bb-d7e8-b8b5-bfb6-510bebbb8808@linux.intel.com>
Date: Fri, 14 Jul 2023 10:50:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, "opensource.kernel"
 <opensource.kernel@vivo.com>, Thierry Reding <treding@nvidia.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHY0XSBpb21tdTogcmVtb3ZlIHJlZHVu?=
 =?UTF-8?Q?dant_parameter_check_in_tegra=5fsmmu=5fdebugfs=5finit=28=29?=
Content-Language: en-US
To: =?UTF-8?B?5p2c5pWP5p2w?= <duminjie@vivo.com>,
 Thierry Reding <thierry.reding@gmail.com>, Krishna Reddy
 <vdumpa@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 "open list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>,
 "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20230713072825.10348-1-duminjie@vivo.com>
 <61f31b3e-b618-88db-a07c-f6761c1c7d06@linux.intel.com>
 <SG2PR06MB5288E9FC9B6EA21E20BB011EAE34A@SG2PR06MB5288.apcprd06.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <SG2PR06MB5288E9FC9B6EA21E20BB011EAE34A@SG2PR06MB5288.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/7/14 10:38, 杜敏杰 wrote:
> Hi baolu!
> 
> Thanks for your suggestion!
> 
> You say:
>> Next time when you send a new version of a patch, please don't forget to add the change log after the tear line. This way, people can know how the patch evolved into this way.
> Do I need to submit a new patch?

Oh no. Just a kind remind. :-)

Best regards,
baolu
