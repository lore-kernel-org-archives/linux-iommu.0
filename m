From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: the imfamous asix ax88179 iommu error
Date: Fri, 6 Oct 2017 17:19:37 +0100
Message-ID: <474710f0-4e19-e4c4-8698-b1d84acffccc@arm.com>
References: <20170929095807.6b02085b@nibenay.lan>
	<20171006111942.773eb515@nibenay.lan>
	<73af1113-86de-25f0-d688-d39e8cfc2c77@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <73af1113-86de-25f0-d688-d39e8cfc2c77-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Trives <renevant-CkBdp7X+a1oIQCUVoCVjmQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/10/17 13:14, Robin Murphy wrote:
> Hi Will,
> 
> On 06/10/17 01:19, Will Trives wrote:
>> Hello,
>>
>> Just reporting that it looks like this patch may fix the error (so
>> people having issues with VIA controller hosts may also want to try it):
>>
>> https://lists.linuxfoundation.org/pipermail/iommu/2017-September/024371.html
>>
>> It appears that my ax88179 is working just fine now with the vendor
>> driver. So perhaps it's possible to revert the old commit in the linux
>> kernel and allow the use of scatter gather ? (perhaps for non-intel
>> hosts ? I'm not sure if this device is effected by intel xhci errata)
> 
> Thanks for the tip-off - as luck would have it I have an AX88179 dongle
> to hand! Does the out-of-tree driver behave significantly differently to
> the mainline driver (CONFIG_USB_NET_AX88179_178A)?

To answer myself - yes, the out-of-tree driver produces all manner of
>PAGE_SIZE offsets for dma_map_sg():

...
[  571.019335] xhci_hcd 0000:04:00.0: ####### sg->offset = 0x7770
[  571.025497] xhci_hcd 0000:04:00.0: ####### sg->offset = 0x7a60
[  571.031402] xhci_hcd 0000:04:00.0: ####### sg->offset = 0x1100
[  571.037353] xhci_hcd 0000:04:00.0: ####### sg->offset = 0x1c50
[  571.043254] xhci_hcd 0000:04:00.0: ####### sg->offset = 0x27a0
...

So my patch should indeed be the right thing to fix the combination of
that driver and intel-iommu.

> I stuck a PCIe USB3 card into my arm64 dev board and brought up the ASIX
> dongle with 4.14-rc3 and the mainline driver - with some added debug
> checks it's definitely not hitting the same sg->offset > PAGE_SIZE case
> as the crypto drivers which prompted the above patch, but I *do* see an
> out-of-bounds DMA access under network load which looks a lot like a
> buffer overrun from the XHCI controller:
> 
> [   41.324904] arm-smmu 2b500000.iommu: Unhandled context fault:
> fsr=0x2, iova=0xfff49000, fsynr=0x183, cb=0
> 
> This is fairly easy to reproduce with iperf, so I'll dig in and see how
> it's related.

And that turns out to be a red herring, in this context at least. In a
cruel twist of fate I'd inadvertently found a card with the infamous VIA
VL805 - it actually does that for any USB3 device, and crucially a
different card with a Renesas chip doesn't.

Robin.

>> commit: e2ed511400d41e0d136089d5a55ceab57c6a2426
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e2ed511400d41e0d136089d5a55ceab57c6a2426
>>
>>
>> ethtool -k enp2s0u1u4
>> Features for enp2s0u1u4:
>> Cannot get device udp-fragmentation-offload settings: Operation not supported
>> rx-checksumming: off [fixed]
>> tx-checksumming: on
>> 	tx-checksum-ipv4: on
>> 	tx-checksum-ip-generic: off [fixed]
>> 	tx-checksum-ipv6: on
>> 	tx-checksum-fcoe-crc: off [fixed]
>> 	tx-checksum-sctp: off [fixed]
>> scatter-gather: on
>> 	tx-scatter-gather: on
>> 	tx-scatter-gather-fraglist: off [fixed]
>> tcp-segmentation-offload: on
>> 	tx-tcp-segmentation: on
>> 	tx-tcp-ecn-segmentation: off [fixed]
>> 	tx-tcp-mangleid-segmentation: off
>> 	tx-tcp6-segmentation: off [fixed]
>> udp-fragmentation-offload: off
>> generic-segmentation-offload: on
>> generic-receive-offload: on
>> large-receive-offload: off [fixed]
>> rx-vlan-offload: off [fixed]
>> tx-vlan-offload: off [fixed]
>> ntuple-filters: off [fixed]
>> receive-hashing: off [fixed]
>> highdma: off [fixed]
>> rx-vlan-filter: off [fixed]
>> vlan-challenged: off [fixed]
>> tx-lockless: off [fixed]
>> netns-local: off [fixed]
>> tx-gso-robust: off [fixed]
>> tx-fcoe-segmentation: off [fixed]
>> tx-gre-segmentation: off [fixed]
>> tx-gre-csum-segmentation: off [fixed]
>> tx-ipxip4-segmentation: off [fixed]
>> tx-ipxip6-segmentation: off [fixed]
>> tx-udp_tnl-segmentation: off [fixed]
>> tx-udp_tnl-csum-segmentation: off [fixed]
>> tx-gso-partial: off [fixed]
>> tx-sctp-segmentation: off [fixed]
>> tx-esp-segmentation: off [fixed]
>> fcoe-mtu: off [fixed]
>> tx-nocache-copy: off
>> loopback: off [fixed]
>> rx-fcs: off [fixed]
>> rx-all: off [fixed]
>> tx-vlan-stag-hw-insert: off [fixed]
>> rx-vlan-stag-hw-parse: off [fixed]
>> rx-vlan-stag-filter: off [fixed]
>> l2-fwd-offload: off [fixed]
>> hw-tc-offload: off [fixed]
>> esp-hw-offload: off [fixed]
>> esp-tx-csum-hw-offload: off [fixed]
>> rx-udp_tunnel-port-offload: off [fixed]
>>
>>
>> Regards,
>>
>>
>> Will 
>>
>> On Fri, 29 Sep 2017 09:58:07 +1000
>> Will Trives <renevant-CkBdp7X+a1oIQCUVoCVjmQ@public.gmane.org> wrote:
>>
>>> Hello,
>>>
>>> I just saw a post about VIA controllers triggering IOMMU errors.
>>>
>>>
>>> Just want to also point out that the ax88179 will also trigger PTE
>>> read errors when using the vendor's driver.
>>>
>>> I'm nowhere near an expert but I remember seeing that 'TD fragment' is
>>> supported now or some such, which I take to mean that sg/tso should be
>>> supported with usbnet ?
>>>
>>> I'm unclear on whether it can ever work with intel hosts because of an
>>> errata ?
>>>
>>> Anyway for anyone that wants to see the error you can grab the vendor
>>> driver:
>>>
>>> http://www.asix.com.tw/FrootAttach/driver/AX88179_178A_LINUX_DRIVER_v1.18.0_SOURCE.tar.bz2
>>>
>>>
>>> This driver was working recently-ish perhaps around the same time the
>>> VIA controllers starting having iommu issues.
>>>
>>>
>>> Regards,
>>>
>>>
>>> Will
>>>
>>>
>>
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
