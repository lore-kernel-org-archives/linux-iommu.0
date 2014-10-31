From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCH v9 14/19] vfio: move eventfd support code for VFIO_PCI to
	a separate file
Date: Fri, 31 Oct 2014 17:03:19 +0100
Message-ID: <CAG8rG2w35mDkkk-ymw19ezhUQE72aEjhOtwBPuzxqkOzYKa6fA@mail.gmail.com>
References: <1414433284-31719-1-git-send-email-a.motakis@virtualopensystems.com>
	<1414433284-31719-15-git-send-email-a.motakis@virtualopensystems.com>
	<CAErSpo55o00=YwtWChFaxC1tEAwv_A5nB90mDU9J6kpb9Tqf_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAErSpo55o00=YwtWChFaxC1tEAwv_A5nB90mDU9J6kpb9Tqf_Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: "open list:VFIO DRIVER" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Alexander Gordeev <agordeev-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 27, 2014 at 8:16 PM, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> Hi Antonios,
>
> On Mon, Oct 27, 2014 at 12:07 PM, Antonios Motakis
> <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org> wrote:
>> The virqfd functionality that is used by VFIO_PCI to implement interrupt
>> masking and unmasking via an eventfd, is generic enough and can be reused
>> by another driver. Move it to a separate file in order to allow the code
>> to be shared.
>>
>> Also properly export virqfd_enable and virqfd_disable in the process.
>
> Alex will handle this, not me, but my personal preference is to avoid
> doing things "in the process" because the small changes get lost in
> the big patch.
>
> I'd rather see a strict move that changes no code at all (except
> things like necessary Makefile changes), followed by a smaller patch
> that does the additional stuff.
>
> Does "properly export" mean that those functions were previously
> *improperly* exported and the way they used to be exported caused a
> problem?  Or does it just mean "export"?

It just means "export", but you are right there is no reason why to
export it in this patch. I will move it to one of the next patches.

>
> Bjorn
>
>> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
>> ---
>>  drivers/vfio/Makefile               |   4 +-
>>  drivers/vfio/pci/vfio_pci_intrs.c   | 213 -----------------------------------
>>  drivers/vfio/pci/vfio_pci_private.h |   3 -
>>  drivers/vfio/virqfd.c               | 214 ++++++++++++++++++++++++++++++++++++
>>  include/linux/vfio.h                |  28 +++++
>>  5 files changed, 245 insertions(+), 217 deletions(-)
>>  create mode 100644 drivers/vfio/virqfd.c
