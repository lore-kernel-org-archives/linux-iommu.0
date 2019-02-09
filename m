From: Sinan Kaya <Okaya@kernel.org>
Subject: Re: [PATCH v1 1/2] PCI: ATS: Add function to check ATS page aligned
 request status.
Date: Fri, 8 Feb 2019 23:49:55 -0500
Message-ID: <815f2621-fc28-bff4-c300-cce7514cfe71@kernel.org>
References: <cover.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <91bfae8b1d4b424219e3ce3c1fc03559c73f1ae7.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5d55e369-355f-b710-0594-03465aa985da@kernel.org>
 <a5a29eee-2e33-ba0c-67a6-69983fd0796d@linux.intel.com>
 <32ec3293-28ea-8f0f-f801-0370b4cf0453@kernel.org>
 <351a1a1d-2517-5021-e7cd-99d700e17f4c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <351a1a1d-2517-5021-e7cd-99d700e17f4c@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Keith Busch <keith.busch@intel.com>
List-Id: iommu@lists.linux-foundation.org

On 2/8/2019 8:02 PM, sathyanarayanan kuppuswamy wrote:
>> This means that you should probably have some kind of version check
>> here.
> 
> There is no version field in ATS v1.0 spec. Also, If I follow the 
> history log in PCI spec, I think ATS if first added at v1.2. Please 
> correct me if I am wrong.

v1.2 was incorporated into PCIe spec at that time. However, the ATS spec
is old and there could be some HW that could claim to be ATS compatible.
I know AMD GPUs declare ATS capability.

See this ECN

https://composter.com.ua/documents/ats_r1.1_26Jan09.pdf

You need to validate the version field from ATS capability header to be
1 before reading this register.

See Table 5-1:  ATS Extended Capability Header
