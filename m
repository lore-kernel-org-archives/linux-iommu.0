From: Sinan Kaya <Okaya@kernel.org>
Subject: Re: [PATCH v1 1/2] PCI: ATS: Add function to check ATS page aligned
 request status.
Date: Mon, 11 Feb 2019 15:35:13 -0500
Message-ID: <a2fcfb40-cc07-87fa-dc52-72c979d9900b@kernel.org>
References: <cover.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <91bfae8b1d4b424219e3ce3c1fc03559c73f1ae7.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5d55e369-355f-b710-0594-03465aa985da@kernel.org>
 <a5a29eee-2e33-ba0c-67a6-69983fd0796d@linux.intel.com>
 <32ec3293-28ea-8f0f-f801-0370b4cf0453@kernel.org>
 <351a1a1d-2517-5021-e7cd-99d700e17f4c@linux.intel.com>
 <815f2621-fc28-bff4-c300-cce7514cfe71@kernel.org>
 <20190211191549.GA12090@otc-nc-03>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211191549.GA12090@otc-nc-03>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Keith Busch <keith.busch@intel.com>
List-Id: iommu@lists.linux-foundation.org

On 2/11/2019 2:15 PM, Raj, Ashok wrote:
> It seems rather odd we have to check for ATS version.
> 
> I always assumed unspecified bits (Reserved) must be 0. We only check
> this if ATS is enabled, and this particular bit wasn't given away for another
> feature.
> 
> Is it really required to check for ATS version before consuming this?

Reading again, it looks like version check is not necessary since it
is implied by the presence of this bit per this paragraph.

Page Aligned Request – If Set, indicates the Untranslated Address is 
always aligned to a 4096 byte boundary.  Setting this bit is 
recommended.  This bit permits software to distinguish between 
implementations compatible with earlier version of this specification 
that permitted a requester to supply anything in bits [11:2].
