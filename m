From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v1 1/2] PCI: ATS: Add function to check ATS page aligned
 request status.
Date: Thu, 7 Feb 2019 20:58:39 -0500
Message-ID: <32ec3293-28ea-8f0f-f801-0370b4cf0453@kernel.org>
References: <cover.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <91bfae8b1d4b424219e3ce3c1fc03559c73f1ae7.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5d55e369-355f-b710-0594-03465aa985da@kernel.org>
 <a5a29eee-2e33-ba0c-67a6-69983fd0796d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a5a29eee-2e33-ba0c-67a6-69983fd0796d@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Keith Busch <keith.busch@intel.com>
List-Id: iommu@lists.linux-foundation.org


On 2/7/2019 5:16 PM, sathyanarayanan kuppuswamy wrote:
>> If I remember this right, aligned request is only supported on ATS v1.1
>> but not supported on v1.0.
> Its added in v1.1.

This means that you should probably have some kind of version check
here.
