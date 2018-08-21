From: Eric Pilmore <epilmore-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>
Subject: Re: IOAT DMA w/IOMMU
Date: Tue, 21 Aug 2018 16:45:20 -0700
Message-ID: <CAOQPn8vO7wP2XGwyJALxkyeBFG6fkTAFgF8QcGiiJF0fOMBa4Q@mail.gmail.com>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
	<20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
	<CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
	<b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
	<CAOQPn8tSNN+3igN-kMcQH46w_a9p6T+S7=c8CLREMLxr1kaTXQ@mail.gmail.com>
	<7068db44-af31-4462-f966-2dd2340ba0f0@deltatee.com>
	<695826a6-e10c-5a30-a51f-7cc61ba6e640@gigaio.com>
	<0d3f48c3-8c4f-4dfb-e883-23c168f12b9b@deltatee.com>
	<14db6acb-da4f-9604-7359-1671210fcb8b@gigaio.com>
	<ad2cd3f2-eb41-d4c2-7614-379c2e458352@deltatee.com>
	<CAOQPn8uuTEcmdQdZB9-A7FT+YWtxSuruGFwmwCPApffTJNs9Vg@mail.gmail.com>
	<41419ada-7f16-0028-1e43-3b4a6c6960b6@deltatee.com>
	<CAOQPn8uyozbmEV0Ww3LW4XDcaY1ZwV0yazsPxPQC0AfLNUhKYw@mail.gmail.com>
	<dd918b52-7ddc-662c-5980-edf3e96ebca2@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <dd918b52-7ddc-662c-5980-edf3e96ebca2-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Kit Chow <kchow-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 21, 2018 at 4:35 PM, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org> wrote:
>
>
> On 21/08/18 05:28 PM, Eric Pilmore wrote:
>>
>>
>> On Tue, Aug 21, 2018 at 4:20 PM, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org
>> <mailto:logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>> wrote:
>>
>>
>>
>>     On 21/08/18 05:18 PM, Eric Pilmore wrote:
>>     > We have been running locally with Kit's change for dma_map_resource and its
>>     > incorporation in ntb_async_tx_submit for the destination address and
>>     > it runs fine
>>     > under "load" (iperf) on a Xeon (Xeon(R) CPU E5-2680 v4 @ 2.40GHz) based system,
>>     > regardless of whether the DMA engine being used is IOAT or a PLX
>>     > device sitting in
>>     > the PCIe tree. However, when we go back to a i7 (i7-7700K CPU @ 4.20GHz) based
>>     > system it seems to run into issues, specifically when put under a
>>     > load. In this case,
>>     > just having a load using a single ping command with an interval=0, i.e. no delay
>>     > between ping packets, after a few thousand packets the system just hangs. No
>>     > panic or watchdogs.  Note that in this scenario I can only use a PLX DMA engine.
>>
>>     This is just my best guess: but it sounds to me like a bug in the PLX
>>     DMA driver or hardware.
>>
>>
>> The PLX DMA driver?  But the PLX driver isn't really even involved in
>> the mapping
>> stage.  Are you thinking maybe the stage at which the DMA descriptor is
>> freed and
>> the PLX DMA driver does a dma_descriptor_unmap?
>
> Hmm, well what would make you think the hang is during
> mapping/unmapping?

Well, the only difference between success and failure is running with the
call to dma_map_resource for the destination address, which is a PCI BAR
address. Prior to Kit introducing this call, we never created a mapping for the
destination PCI BAR address and it worked fine on all systems when using
PLX DMA. It was only when we went to a Xeon system and attempted to use
IOAT DMA that we found we needed a mapping for that destination PCI BAR
address.

The only thing the PLX driver does related to "mappings" is a call to
dma_descriptor_unmap when the descriptor is freed, however that is more
of an administrative step to clean up the unmap-data data structure used
when the mapping was originally established.

> I would expect a hang to be in handling completions
> from the DMA engine or something like that.
>
>> Again, PLX did not exhibit any issues on the Xeon system.
>
> Oh, I missed that. That puts a crinkle in my theory but, as you say, it
> could be a timing issue.
>
> Also, it's VERY strange that it would hang the entire system. That makes
> things very hard to debug...

Tell me about it!  ;-)

Eric
