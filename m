From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH V2 RFC] fixup! virtio: convert to use DMA api
Date: Wed, 27 Apr 2016 16:58:51 +0200
Message-ID: <20160427145851.GJ17926@8bytes.org>
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
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160427175031-mutt-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, David Woodhouse <dwmw2@infradead.org>, Kevin Wolf <kwolf@redhat.com>, Wei Liu <wei.liu2@citrix.com>, Andy Lutomirski <luto@kernel.org>, qemu-block@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Jason Wang <jasowang@redhat.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, peterx@redhat.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Amit Shah <amit.shah@redhat.com>, iommu@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, kvm list <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Anthony PERARD <anthony.perard@citrix.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 27, 2016 at 05:54:57PM +0300, Michael S. Tsirkin wrote:
> Point is, QEMU is not the only virtio implementation out there.
> So we can't know no virtio implementations have an IOMMU as long as
> linux supports this IOMMU.
> virtio always used physical addresses since it was born and if it
> changes that it must do this in a way that does not break existing
> users.

FWIW, virtio in qemu can continue to just use physical addresses. But
qemu needs to advertise that fact correctly to the OS in the DMAR table.
This way old kernels (where virtio does not use DMA-API) will also
continue to work on the fixed qemu.



	Joerg
