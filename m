From: Oza Oza <oza.oza@broadcom.com>
Subject: Re: [PATCH v7 2/3] PCI: Add support for PCI inbound windows resources
Date: Thu, 1 Jun 2017 23:36:17 +0530
Message-ID: <CAMSpPPezWVzU2pevgoZPFwT+oDv+-BySn46WAjY3KFx4ffEV8g@mail.gmail.com>
References: <1495471182-12490-1-git-send-email-oza.oza@broadcom.com>
 <1495471182-12490-3-git-send-email-oza.oza@broadcom.com> <CAErSpo6MJbNEyGQC4MwFb6kPoOf1p=mxk-SHAz-+HuDFbvRkmw@mail.gmail.com>
 <CAMSpPPdXbCteC7scb99CMKqdif0q9ngZnzJMhGa6xZt7BM0yKg@mail.gmail.com> <CAErSpo58xJbQG_UK76pW55phs32Bqeyv=_wtJTS2jvf6JQ2MAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo58xJbQG_UK76pW55phs32Bqeyv=_wtJTS2jvf6JQ2MAA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Oza Pawandeep <oza.pawandeep@gmail.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 1, 2017 at 10:38 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, May 31, 2017 at 11:17 AM, Oza Oza <oza.oza@broadcom.com> wrote:
>> On Wed, May 31, 2017 at 4:12 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> On Mon, May 22, 2017 at 11:39 AM, Oza Pawandeep <oza.oza@broadcom.com> wrote:
>>>> This patch adds support for inbound memory window
>>>> for PCI RC drivers.
>>>>
>>>> It defines new function pci_create_root_bus2 which
>>>> takes inbound resources as an argument and fills in the
>>>> memory resource to PCI internal host bridge structure
>>>> as inbound_windows.
>>>>
>>>> Legacy RC driver could continue to use pci_create_root_bus,
>>>> but any RC driver who wants to reseve IOVAS for their
>>>> inbound memory holes, should use new API pci_create_root_bus2.
>>>>
>>>> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
>>>> ...
>>>
>>>> +struct pci_bus *pci_create_root_bus2(struct device *parent, int bus,
>>>> +               struct pci_ops *ops, void *sysdata, struct list_head *resources,
>>>> +               struct list_head *in_res)
>>>> +{
>>>> +       return pci_create_root_bus_msi(parent, bus, ops, sysdata,
>>>> +                                      resources, in_res, NULL);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(pci_create_root_bus2);
>>>
>>> Based on your response to Lorenzo's "[RFC/RFT PATCH 03/18] PCI:
>>> Introduce pci_scan_root_bus_bridge()", I'm hoping you can avoid adding
>>> yet another variant of pci_create_root_bus().
>>>
>>> So I think I can wait for that to settle out and look for a v8?
>>>
>>> Bjorn
>>
>> Sure Bjorn, please wait for v8.
>>
>> But there is one more associated patch
>> [PATCH v7 1/3] OF/PCI: Export inbound memory interface to PCI RC
>> which basically aims to provide an interface to RC drivers for their
>> inbound resources.
>> RC driver already get their outbound resources from
>> of_pci_get_host_bridge_resources,
>> similar attempt for inbound dma-ranges.
>
> Not sure I understand.  Patch 1/3 adds of_pci_get_dma_ranges(), but
> none of the patches adds a caller, so I don't see the point of it yet.
>
> In general, if I'm expecting another revision of one patch in a
> series, I expect the next revision to include *all* the patches in the
> series.  I normally don't pick out and apply individual patches from
> the series.
>
> Bjorn

Yes, it does not get called by anybody, because it is supposed to be called
by RC drivers who want to reserve IOVAs, not all the PCI host bridge driver
might call it, but certainly iproc based PCI driver has to call it.

Then I will have PATCH v8, and with that, I will include PCI RC driver
patch calling it as well.
Thanks for the Review.

Regards,
Oza.
