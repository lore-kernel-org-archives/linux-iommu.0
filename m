From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH V2 RFC] fixup! virtio: convert to use DMA
 api
Date: Wed, 27 Apr 2016 08:10:42 -0700
Message-ID: <CALCETrVfOTrq_QwJNYLqeLpGPFrY=YWSW5Fin36vH6v_wWq=gw@mail.gmail.com>
References: <1461245745-6710-1-git-send-email-mst@redhat.com>
	<20160421135416.GE11775@citrix.com>
	<1461759501.118304.149.camel@infradead.org>
	<20160427153345-mutt-send-email-mst@redhat.com>
	<20160427142331.GH17926@8bytes.org>
	<CALCETrVkSSJbjoK8i7pLsSYR0o=Wy1UP-mrmn2uxYUd81g18dg@mail.gmail.com>
	<20160427173603-mutt-send-email-mst@redhat.com>
	<CALCETrUnXSLApj--ypOHnLWLqVSHLpSa922F2C2OCrvA1B585A@mail.gmail.com>
	<20160427175031-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <qemu-block-bounces+gceqb-qemu-block=m.gmane.org@nongnu.org>
In-Reply-To: <20160427175031-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-block>,
	<mailto:qemu-block-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-block/>
List-Post: <mailto:qemu-block@nongnu.org>
List-Help: <mailto:qemu-block-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-block>,
	<mailto:qemu-block-request@nongnu.org?subject=subscribe>
Errors-To: qemu-block-bounces+gceqb-qemu-block=m.gmane.org@nongnu.org
Sender: "Qemu-block"
	<qemu-block-bounces+gceqb-qemu-block=m.gmane.org@nongnu.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Wei Liu <wei.liu2@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Joerg Roedel <joro@8bytes.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, peterx@redhat.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, iommu@lists.linux-foundation.org, Andy Lutomirski <luto@kernel.org>, kvm list <kvm@vger.kernel.org>, Amit Shah <amit.shah@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 27, 2016 at 7:54 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Apr 27, 2016 at 07:43:07AM -0700, Andy Lutomirski wrote:
>> On Wed, Apr 27, 2016 at 7:38 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Wed, Apr 27, 2016 at 07:31:43AM -0700, Andy Lutomirski wrote:
>> >> On Wed, Apr 27, 2016 at 7:23 AM, Joerg Roedel <joro@8bytes.org> wrote:
>> >> > On Wed, Apr 27, 2016 at 04:37:04PM +0300, Michael S. Tsirkin wrote:
>> >> >> One correction: it's a feature of the device in the system.
>> >> >> There could be a mix of devices bypassing and not
>> >> >> bypassing the IOMMU.
>> >> >
>> >> > No, it really is not. A device can't chose to bypass the IOMMU. But the
>> >> > IOMMU can chose to let the device bypass. So any fix here belongs
>> >> > into the platform/iommu code too and not into some driver.
>> >> >
>> >> >> Sounds good. And a way to detect appropriate devices could
>> >> >> be by looking at the feature flag, perhaps?
>> >> >
>> >> > Again, no! The way to detect that is to look into the iommu description
>> >> > structures provided by the firmware. They provide everything necessary
>> >> > to tell the iommu code which devices are not translated.
>> >> >
>> >>
>> >> Except on PPC and SPARC.  As far as I know, those are the only
>> >> problematic platforms.
>> >>
>> >> Is it too late to *disable* QEMU's q35-iommu thingy until it can be
>> >> fixed to report correct data in the DMAR tables?
>> >>
>> >> --Andy
>> >
>> > Meaning virtio or assigned devices?
>> > For virtio - it's way too late since these are working configurations.
>> > For assigned devices - they don't work on x86 so it doesn't have
>> > to be disabled, it's safe to ignore.
>>
>> I mean actually prevent QEMU from running in q35-iommu mode with any
>> virtio devices attached or maybe even turn off q35-iommu mode entirely
>> [1].  Doesn't it require that the user literally pass the word
>> "experimental" into QEMU right now?  It did at some point IIRC.
>>
>> The reason I'm asking is that, other than q35-iommu, QEMU's virtio
>> devices *don't* bypass the IOMMU except on PPC and SPARC, simply
>> because there is no other configuration AFAICT that has virtio and and
>> IOMMU.  So maybe the right solution is to fix q35-iommu to use DMAR
>> correctly (thus breaking q35-iommu users with older guest kernels,
>> which hopefully don't actually exist) and to come up with a PPC- and
>> SPARC-specific solution, or maybe OpenFirmware-specific solution, to
>> handle PPC and SPARC down the road.
>>
>> [1] I'm pretty sure I emailed the QEMU list before q35-iommu ever
>> showed up in a release asking the QEMU team to please not do that
>> until this issue was resolved.  Sadly, that email was ignored :(
>>
>> --Andy
>
> Sorry, I didn't make myself clear.
> Point is, QEMU is not the only virtio implementation out there.
> So we can't know no virtio implementations have an IOMMU as long as
> linux supports this IOMMU.
> virtio always used physical addresses since it was born and if it
> changes that it must do this in a way that does not break existing
> users.

Is there any non-QEMU virtio implementation can provide an
IOMMU-bypassing virtio device on a platform that has a nontrivial
IOMMU?

--Andy
