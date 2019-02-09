From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v1 1/2] PCI: ATS: Add function to check ATS page aligned
 request status.
Date: Fri, 8 Feb 2019 17:02:33 -0800
Message-ID: <351a1a1d-2517-5021-e7cd-99d700e17f4c@linux.intel.com>
References: <cover.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <91bfae8b1d4b424219e3ce3c1fc03559c73f1ae7.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5d55e369-355f-b710-0594-03465aa985da@kernel.org>
 <a5a29eee-2e33-ba0c-67a6-69983fd0796d@linux.intel.com>
 <32ec3293-28ea-8f0f-f801-0370b4cf0453@kernel.org>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <32ec3293-28ea-8f0f-f801-0370b4cf0453@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>, bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Keith Busch <keith.busch@intel.com>
List-Id: iommu@lists.linux-foundation.org


On 2/7/19 5:58 PM, Sinan Kaya wrote:
>
> On 2/7/2019 5:16 PM, sathyanarayanan kuppuswamy wrote:
>>> If I remember this right, aligned request is only supported on ATS v1.1
>>> but not supported on v1.0.
>> Its added in v1.1.
>
> This means that you should probably have some kind of version check
> here.

There is no version field in ATS v1.0 spec. Also, If I follow the 
history log in PCI spec, I think ATS if first added at v1.2. Please 
correct me if I am wrong.

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer
