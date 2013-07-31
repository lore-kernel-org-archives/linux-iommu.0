From: Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: AMD IOMMU: Please support Marvell 88SE91xx SATA Controllers
Date: Wed, 31 Jul 2013 19:07:21 +0800
Message-ID: <CAJtEV7bAVKVW4YZwmFDjMs7F3tab+ifpnVcq3jBqFa9gvtL+8A@mail.gmail.com>
References: <519A93F0.8070606@gmx.ch> <20130521203526.GE7424@8bytes.org>
	<51D3E691.8030307@gmx.ch> <20130730113954.GK28811@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130730113954.GK28811-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Manfred Schwarb <manfred99-OI3hZJvNYWs@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg

On Tue, Jul 30, 2013 at 7:39 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> Hi Andrew,
>
> On Wed, Jul 03, 2013 at 10:53:37AM +0200, Manfred Schwarb wrote:
>> Am 21.05.2013 22:35, schrieb Joerg Roedel:
>> >On Mon, May 20, 2013 at 11:21:52PM +0200, Manfred Schwarb wrote:
>> >>Is anybody working on this issue for the AMD part? I would be very
>> >>grateful if such support could be added to the linux kernel. I would
>> >>be prepared to test patches, if needed.
>
> Somehow the workaround for Intel didn't make it upstream. Do you plan to
> continue working on the workaround?

I think some of the issues that prevented the workaround from being
merged will be addressed by Alex Williamson's PCIe requester ID
interface patch set, which is currently being discussed[1].

That patch should bring the pci_get_dma_source() workaround into the
main dma ops path, after which it can be changed to allow for devices
that use multiple or otherwise incorrect requestor ids.

[1] http://thread.gmane.org/gmane.linux.kernel.pci/23876/focus=2599
>
> I reused a few parts of your VT-d patch to implement the workaround for
> AMD, there is surely potential to have some common code between the
> IOMMU drivers for this.

Thanks for that.

a.
