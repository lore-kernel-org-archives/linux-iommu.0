From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 1/5] pci/p2p: add a function to test peer to peer
 capability
Date: Tue, 29 Jan 2019 11:24:09 -0700
Message-ID: <f66ba584-9c4a-f6cd-c647-9b32a93be807@deltatee.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-2-jglisse@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129174728.6430-2-jglisse@redhat.com>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: jglisse@redhat.com, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org



On 2019-01-29 10:47 a.m., jglisse@redhat.com wrote:
> +bool pci_test_p2p(struct device *devA, struct device *devB)
> +{
> +	struct pci_dev *pciA, *pciB;
> +	bool ret;
> +	int tmp;
> +
> +	/*
> +	 * For now we only support PCIE peer to peer but other inter-connect
> +	 * can be added.
> +	 */
> +	pciA = find_parent_pci_dev(devA);
> +	pciB = find_parent_pci_dev(devB);
> +	if (pciA == NULL || pciB == NULL) {
> +		ret = false;
> +		goto out;
> +	}
> +
> +	tmp = upstream_bridge_distance(pciA, pciB, NULL);
> +	ret = tmp < 0 ? false : true;
> +
> +out:
> +	pci_dev_put(pciB);
> +	pci_dev_put(pciA);
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(pci_test_p2p);

This function only ever returns false....

Logan
