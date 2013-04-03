From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 5/5 v11] iommu/fsl: Freescale PAMU driver and iommu
 implementation.
Date: Tue, 2 Apr 2013 20:35:54 -0500
Message-ID: <CAOZdJXWS50mpgMYu8o8K11yQFU6y-vNwxd9zPkqSd7euGt7XQg@mail.gmail.com>
References: <1364500442-20927-1-git-send-email-Varun.Sethi@freescale.com>
 <1364500442-20927-6-git-send-email-Varun.Sethi@freescale.com>
 <20130402161812.GI15687@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20130402161812.GI15687@8bytes.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: stuart.yoder@freescale.com, lkml <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, scottwood@freescale.com, Varun Sethi <Varun.Sethi@freescale.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 2, 2013 at 11:18 AM, Joerg Roedel <joro@8bytes.org> wrote:

> > +     panic("\n");
>
> A kernel panic seems like an over-reaction to an access violation.

We have no way to determining what code caused the violation, so we
can't just kill the process.  I agree it seems like overkill, but what
else should we do?  Does the IOMMU layer have a way for the IOMMU
driver to stop the device that caused the problem?

> Besides the device that caused the violation the system should still
> work, no?

Not really.  The PAMU was designed to add IOMMU support to legacy
devices, which have no concept of an MMU.  If the PAMU detects an
access violation, there's no way for the device to recover, because it
has no idea that a violation has occurred.  It's going to keep on
writing to bad data.

Maybe we need a mechanism where a driver can register a callback
function to handle IOMMU exceptions?

> > +     /*
> > +      * In case of devices with multiple LIODNs just store
> > +      * the info for the first LIODN as all
> > +      * LIODNs share the same domain
> > +      */
> > +     if (!old_domain_info)
> > +             dev->archdata.iommu_domain = info;
> > +     spin_unlock(&device_domain_lock);
>
> Don't you have to tell the hardware that a device was added to a domain?
> I don't see that, what I am missing?

I'm not sure I understand.  What "hardware" do you think needs to be notified?

The PAMU reads everything it needs from the PAACT, which we update.
The PAMU does not know anything about the devices that it monitors,
and the devices don't know anything about the PAMU.
