From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v1 1/2] PCI: ATS: Add function to check ATS page aligned
 request status.
Date: Thu, 7 Feb 2019 15:38:35 -0500
Message-ID: <5d55e369-355f-b710-0594-03465aa985da@kernel.org>
References: <cover.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <91bfae8b1d4b424219e3ce3c1fc03559c73f1ae7.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <91bfae8b1d4b424219e3ce3c1fc03559c73f1ae7.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Keith Busch <keith.busch@intel.com>
List-Id: iommu@lists.linux-foundation.org


On 2/7/2019 1:41 PM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> + * As per PCI spec, If page aligned request bit is set, it indicates
> + * the untranslated address is always aligned to a 4096 byte boundary.
> + */
> +int pci_ats_page_aligned(struct pci_dev *pdev)
> +{
> +	u16 cap;
> +
> +	if (!pdev->ats_cap)
> +		return 0;
> +
> +	pci_read_config_word(pdev, pdev->ats_cap + PCI_ATS_CAP, &cap);

If I remember this right, aligned request is only supported on ATS v1.1
but not supported on v1.0.

Can you please check the spec?
