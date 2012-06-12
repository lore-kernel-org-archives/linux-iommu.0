From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 0/5] PCI: Prep for VFIO and IOMMU Groups
Date: Mon, 11 Jun 2012 18:59:25 -0600
Message-ID: <CAErSpo434tDtnSOxB_REG2jFNrZL=aZERWTmmK-cdjqM4z6yWg@mail.gmail.com>
References: <20120611152021.25959.71601.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120611152021.25959.71601.stgit@bling.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org, aik@ozlabs.ru, david@gibson.dropbear.id.au, joerg.roedel@amd.com, dwmw2@infradead.org, konrad.wilk@oracle.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, ddutile@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 11, 2012 at 8:26 AM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> v3:
> =A0- Small change to device specific ACS check to allow quirk to
> =A0 support yes/no/pass type functionality. (no change to other
> =A0 patches and no trickle down through IOMMU series)
>
> Bjorn, what's needed to get these in? =A0Thanks,

Sorry for the delay.  I applied these to my "next" branch (headed for
3.6).  I didn't feel comfortable pushing them towards 3.5 since
they're not bugfixes, and they haven't been in -next yet.

Bjorn
