From: Bjorn Helgaas via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v7 2/3] PCI: Add support for PCI inbound windows resources
Date: Thu, 1 Jun 2017 12:08:59 -0500
Message-ID: <CAErSpo58xJbQG_UK76pW55phs32Bqeyv=_wtJTS2jvf6JQ2MAA@mail.gmail.com>
References: <1495471182-12490-1-git-send-email-oza.oza@broadcom.com>
	<1495471182-12490-3-git-send-email-oza.oza@broadcom.com>
	<CAErSpo6MJbNEyGQC4MwFb6kPoOf1p=mxk-SHAz-+HuDFbvRkmw@mail.gmail.com>
	<CAMSpPPdXbCteC7scb99CMKqdif0q9ngZnzJMhGa6xZt7BM0yKg@mail.gmail.com>
Reply-To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMSpPPdXbCteC7scb99CMKqdif0q9ngZnzJMhGa6xZt7BM0yKg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Oza Oza <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Oza Pawandeep <oza.pawandeep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, May 31, 2017 at 11:17 AM, Oza Oza <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
> On Wed, May 31, 2017 at 4:12 AM, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
>> On Mon, May 22, 2017 at 11:39 AM, Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
>>> This patch adds support for inbound memory window
>>> for PCI RC drivers.
>>>
>>> It defines new function pci_create_root_bus2 which
>>> takes inbound resources as an argument and fills in the
>>> memory resource to PCI internal host bridge structure
>>> as inbound_windows.
>>>
>>> Legacy RC driver could continue to use pci_create_root_bus,
>>> but any RC driver who wants to reseve IOVAS for their
>>> inbound memory holes, should use new API pci_create_root_bus2.
>>>
>>> Signed-off-by: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>>> ...
>>
>>> +struct pci_bus *pci_create_root_bus2(struct device *parent, int bus,
>>> +               struct pci_ops *ops, void *sysdata, struct list_head *resources,
>>> +               struct list_head *in_res)
>>> +{
>>> +       return pci_create_root_bus_msi(parent, bus, ops, sysdata,
>>> +                                      resources, in_res, NULL);
>>> +}
>>> +EXPORT_SYMBOL_GPL(pci_create_root_bus2);
>>
>> Based on your response to Lorenzo's "[RFC/RFT PATCH 03/18] PCI:
>> Introduce pci_scan_root_bus_bridge()", I'm hoping you can avoid adding
>> yet another variant of pci_create_root_bus().
>>
>> So I think I can wait for that to settle out and look for a v8?
>>
>> Bjorn
>
> Sure Bjorn, please wait for v8.
>
> But there is one more associated patch
> [PATCH v7 1/3] OF/PCI: Export inbound memory interface to PCI RC
> which basically aims to provide an interface to RC drivers for their
> inbound resources.
> RC driver already get their outbound resources from
> of_pci_get_host_bridge_resources,
> similar attempt for inbound dma-ranges.

Not sure I understand.  Patch 1/3 adds of_pci_get_dma_ranges(), but
none of the patches adds a caller, so I don't see the point of it yet.

In general, if I'm expecting another revision of one patch in a
series, I expect the next revision to include *all* the patches in the
series.  I normally don't pick out and apply individual patches from
the series.

Bjorn
