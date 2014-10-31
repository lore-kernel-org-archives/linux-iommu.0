From: Antonios Motakis <a.motakis@virtualopensystems.com>
Subject: Re: [PATCH v9 17/19] vfio: virqfd: add vfio_ prefix to virqfd_enable
 and virqfd_disable
Date: Fri, 31 Oct 2014 17:06:43 +0100
Message-ID: <CAG8rG2yb1iQBtVtUFky+XKTYSWgv2curH8LpaASCOMuzLOK9HQ@mail.gmail.com>
References: <1414433284-31719-1-git-send-email-a.motakis@virtualopensystems.com>
 <1414433284-31719-18-git-send-email-a.motakis@virtualopensystems.com> <CAErSpo7AD4ZJa=N5TqbSfdHjH2miL27Fvc5wsjqo_Q6sk2-cDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAErSpo7AD4ZJa=N5TqbSfdHjH2miL27Fvc5wsjqo_Q6sk2-cDg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: kvm-arm <kvmarm@lists.cs.columbia.edu>, "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, Will Deacon <will.deacon@arm.com>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>, Christoffer Dall <christoffer.dall@linaro.org>, Eric Auger <eric.auger@linaro.org>, Kim Phillips <kim.phillips@freescale.com>, Marc Zyngier <marc.zyngier@arm.com>, Alexander Gordeev <agordeev@redhat.com>, "open list:VFIO DRIVER" <kvm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 27, 2014 at 9:12 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Oct 27, 2014 at 12:08 PM, Antonios Motakis
> <a.motakis@virtualopensystems.com> wrote:
>> The virqfd_enable and virqfd_disable functions are now global. Add the
>> vfio_ prefix to those functions.
>
> Wouldn't it be better to change the name *before* making them global?

I will add a separate patch for renaming & exporting at the same time.

>
> Bjorn
