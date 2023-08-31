Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4AD53BD
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 07:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693467342; x=1725003342;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gGq0f2IanlncZao5pAyi3R+UQp26HkPckTg5kZDrgco=;
  b=iOYl9ZxrpPlULJ4Z1jlB8eJyPRK//+dhmqEXmOljyvnVU/kZc+B1eaAC
   qanzZyhMc/9nwtvWGSo6Tg/Z4begbgoDwBS4Sl9XyGU2t7glIYG6s1AFJ
   QIcLSKJO0iDYPBOVtwpE6NLslPzXNFJPhTcvTVzav2pSwUxVjXuaFvs/1
   JR4JLTAqY6L+9CP+PHK04jwQpKHQXZUuIw43+A1W24nbPfZS9CTXB9qIW
   AdDgeLrqOdr/X23x2L2RswyjbFPgI4FwjKiLIU5eGDy81p4W1IsrpVthz
   EoC5DnZtsVhhJ8dU0XSDyQdxCOLbKRJjg2c8gGnEj2bWzvmZdBEn98mrH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="373248502"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="373248502"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 00:35:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="774421187"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="774421187"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.87]) ([10.254.210.87])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 00:35:39 -0700
Message-ID: <ef751928-7123-6840-f080-ca63e24e5ece@linux.intel.com>
Date: Thu, 31 Aug 2023 15:35:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, Tina Zhang <tina.zhang@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Michael Shavit <mshavit@google.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iommu: Support mm PASID 1:n with sva domains
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-5-tina.zhang@intel.com>
 <aa834f12-ce45-fe15-430b-2a9c3446a5ba@amd.com> <ZO+oRPOf9jyNG2+B@ziepe.ca>
 <20b44fe8-33ba-d6ae-110e-a82a19390bcc@amd.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20b44fe8-33ba-d6ae-110e-a82a19390bcc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/31 14:42, Vasant Hegde wrote:
>>> Also in this function (mm_pasid_drop()), should we check/free sva domains?
>> No, the driver must support a SVA domain with an empty mm_struct, eg
>> by hooking release.
> Sorry. Looks like confused you. Looking into code I got this.
> 
> My question was: when PASID is enabled, is there any chance of mm_pasid_drop()
> getting called before freeing all SVA domains?

I remember we have discussed this during sva development. If I remember
it correctly, in any case, mm_pasid_drop() will be called after the
device is closed. The device driver will detach the sva domains in the
close path.

Best regards,
baolu
