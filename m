Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AA0568B
	for <iommu@lists.linux.dev>; Wed, 12 Apr 2023 14:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681308191; x=1712844191;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n/9nWg9ADNDZxhAMoIa6mw8OZXc7bxhlG+mD8jYD9jY=;
  b=XefndBM0zb6aXqwcqgMIvcO6yJpYWhhQcT2GImtQQnZ4h8wJx+6EbRqt
   46JrovrwvLgDDb/NZslr9ZZAWhRAMP09QgfG3oxXfdc8leKz8WspZOAvj
   Rd2ToXLZOqJTbybAUUvW0aFRbCHFsQVv2LIQf4+XL7eRTZ9kdfrPNgctq
   NWg70G0g93Asymf09oKUNQayRzmoq/bMngACPLa5vybo3r8GLZNEzCYDv
   ssRjJbDtT4an793GLYx/wRNGdnsPXgRPPrp2YPUbb09JNWOXe6k7yXCyr
   TcKVLOwiEzyNra91/S+O85y2QbI7N+M8RKV/Xa6+YhR65BYu1UugDkj3R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="342660769"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="342660769"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 07:02:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="691540396"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="691540396"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.58]) ([10.254.215.58])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 07:02:45 -0700
Message-ID: <b90f0222-3faa-b909-c82a-d4fbf8a1a1ae@linux.intel.com>
Date: Wed, 12 Apr 2023 22:02:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc: baolu.lu@linux.intel.com, Vinod Koul <vkoul@kernel.org>,
 Tina Zhang <tina.zhang@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>, Joerg Roedel <joro@8bytes.org>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
 <20230411064815.31456-12-baolu.lu@linux.intel.com>
 <ec1536af68e6478a9b10a0d884cc988d@AcuMS.aculab.com>
 <6d9ed10d-12ee-792f-fc34-60a8e432c5d2@linux.intel.com>
 <b6ab9a30960d41c9b42e5880b89277e3@AcuMS.aculab.com>
 <cbf041c7-119b-e23a-185d-288194629324@linux.intel.com>
 <d996281ed80647e0ae38cea00285f710@AcuMS.aculab.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <d996281ed80647e0ae38cea00285f710@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/4/12 21:27, David Laight wrote:
> From: Baolu Lu
>> Sent: 12 April 2023 14:11
> ...
>> The addresses the following issue reported by klocwork tool:
>>
>>    - operands of different size in bitwise operations
> Then fix the stupid tool to not be that pedantic.

Good idea. But before the users/customers stop complaining, let's have a
cleanup like this. :-)

Best regards,
baolu
