From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue
Date: Fri, 5 May 2017 11:27:06 -0600
Message-ID: <20170505112706.7785948c@t450s.home>
References: <575f8fbc-0fdc-f336-e3da-53f27da4b2e1@markju.com>
        <CAOcCaLbdi9KZoXiV5htjShc_mYvZ5jK2B3Ot7NeM=3v_ZA39aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CAOcCaLbdi9KZoXiV5htjShc_mYvZ5jK2B3Ot7NeM=3v_ZA39aA@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Nick Sarnie <commendsarnex@gmail.com>
Cc: Matthias Ehrenfeuchter <efeu@markju.com>, iommu@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 3 May 2017 12:28:35 -0400
Nick Sarnie <commendsarnex@gmail.com> wrote:

> On Wed, May 3, 2017 at 10:37 AM, Matthias Ehrenfeuchter <efeu@markju.com> wrote:
> > Hi,
> >
> > There are a lot of messages/threads out there about bad performance while
> > using AMDs Ryzen with KVM GPU passthrough. It revolves all on
> > enabling/disabling npt, while enabled overall VM performance is nice but the
> > GPU performance gives me about 20% (and a lot of drops to zero GPU usage,
> > while CPU/Disk/Ram also doing nothing) compared to npt disabled. But while
> > npt is disabled overall VM performance is like beeing on 4x86 with floppy
> > disk as only storage. (Ex. it takes 2 seconds just to open startmenu while
> > host and vm are in idle, and neither CPU pinning, changing CPU model,
> > changing storage device nor using hugepages changed anything).
> >
> > So everything I read pointed to a bug in the npt implementation? Anything I
> > could do to get closer to the "thing" issuing this?
> >
> > Best Regards
> >
> > efeu
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu  
> 
> I heard from Joerg that it might be related to a lower intercept rate
> being used when NPT is enabled, but we haven't been able to find a way
> to trace that to confirm.

Joerg/Paolo, any ideas how we might debug this?  Anyone from AMD
watching?  Thanks,

Alex
