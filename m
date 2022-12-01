Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365D7C
	for <iommu@lists.linux.dev>; Thu,  1 Dec 2022 04:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669867501; x=1701403501;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7CgR77O/LJ+qQwdekEAOR+ICLchwcbKNO5+WIEKDxVw=;
  b=StNvL/8BEPV0ET7ndeNh96TlyUr+aZKH8e7BJAa7kdjkJcQj7Fh+Rn45
   nVp91thq2nQrBgS1KrKIZl0YrGvZMzcy9bJTOCZHR4gIJr5uJh75bKHLW
   ONJSa/+qT7HWyMsJHcttvawvgE++G/rE6D1RTBgUWrlS9lXtbyTNpIHKz
   ASz51jLXeQUhnjCcWu2xFUU+EtzsGO/23IxDMNsaNKzapXi0NDE8fax/r
   Wo2l7q+6jQfTywYHJk/NRn4qzzZsGke5l3pl1Rted6EF7xEFpfT86FVNj
   B/MtuDbsIrvVN4e/C4a1ni2loMG/+1CFaCI0JD0dwrIGC0qmfkE7rpZcc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="379856453"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="379856453"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 20:05:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="786735021"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="786735021"
Received: from xuhuiyan-mobl1.ccr.corp.intel.com (HELO [10.254.215.206]) ([10.254.215.206])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 20:04:58 -0800
Message-ID: <67775808-de49-7de6-66dd-e095ee9bbcc1@linux.intel.com>
Date: Thu, 1 Dec 2022 12:04:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, yangyingliang@huawei.com
Subject: Re: [PATCH 0/2] iommu/vt-d: Fix PCI device reference count leak
Content-Language: en-US
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, jroedel@suse.de
References: <20221121113649.190393-1-wangxiongfeng2@huawei.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221121113649.190393-1-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/11/21 19:36, Xiongfeng Wang wrote:
> for_each_pci_dev() is implemented by pci_get_device(). The comment of
> pci_get_device() says that it will increase the reference count for the
> returned pci_dev and also decrease the reference count for the input
> pci_dev @from if it is not NULL.
> 
> If we break for_each_pci_dev() loop with pdev not NULL, we need to call
> pci_dev_put() to decrease the reference count.
> 
> Xiongfeng Wang (2):
>    iommu/vt-d: Fix PCI device reference count leak in has_external pci()
>    iommu/vt-d: Fix PCI device reference count leak in
>      dmar_dev_scope_init()

Queued for Joerg. Thank you!

Best regards,
baolu
