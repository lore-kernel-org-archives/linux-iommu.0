From: Jerome Glisse <j.glisse@gmail.com>
Subject: Re: [PATCH 1/6] mmput: use notifier chain to call subsystem exit
 handler.
Date: Mon, 30 Jun 2014 12:06:05 -0400
Message-ID: <20140630160604.GF1956@gmail.com>
References: <1403920822-14488-1-git-send-email-j.glisse@gmail.com>
 <1403920822-14488-2-git-send-email-j.glisse@gmail.com>
 <019CCE693E457142B37B791721487FD91806B836@storexdag01.amd.com>
 <20140630154042.GD26537@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20140630154042.GD26537@8bytes.org>
Sender: owner-linux-mm@kvack.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Gabbay, Oded" <Oded.Gabbay@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lewycky, Andrew" <Andrew.Lewycky@amd.com>, "Cornwall, Jay" <Jay.Cornwall@amd.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mgorman@suse.de" <mgorman@suse.de>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infraread.org" <peterz@infraread.org>, "aarcange@redhat.com" <aarcange@redhat.com>, "riel@redhat.com" <riel@redhat.com>, "jweiner@redhat.com" <jweiner@redhat.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, Mark Hairgrove <mhairgrove@nvidia.com>, Jatin Kumar <jakumar@nvidia.com>, Subhash Gutti <sgutti@nvidia.com>, Lucien Dunning <ldunning@nvidia.com>, Cameron Buschardt <cabuschardt@nvidia.com>, Arvind Gopalakrishnan <arvindg@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 30, 2014 at 05:40:42PM +0200, Joerg Roedel wrote:
> On Mon, Jun 30, 2014 at 02:41:24PM +0000, Gabbay, Oded wrote:
> > I did face some problems regarding the amd IOMMU v2 driver, which
> > changed its behavior (see commit "iommu/amd: Implement
> > mmu_notifier_release call-back") to use mmu_notifier_release and did
> > some "bad things" inside that
> > notifier (primarily, but not only, deleting the object which held the
> > mmu_notifier object itself, which you mustn't do because of the
> > locking).=20
> >=20
> > I'm thinking of changing that driver's behavior to use this new
> > mechanism instead of using mmu_notifier_release. Does that seem
> > acceptable ? Another solution will be to add a new mmu_notifier call,
> > but we already ruled that out ;)
>=20
> The mmu_notifier_release() function is exactly what this new notifier
> aims to do. Unless there is a very compelling reason to duplicate this
> functionality I stronly NACK this approach.
>=20
>

No this patch does not duplicate it. Current user of mmu_notifier
rely on file close code path to call mmu_notifier_unregister. New
code like AMD IOMMUv2 or HMM can not rely on that. Thus they need
a way to call the mmu_notifer_unregister (which can not be done
from inside the the release call back).

If you look at current code the release callback is use to kill
secondary translation but not to free associated resources. All
the associated resources are free later on after the release
callback (well it depends if the file is close before the process
is kill).

So this patch aims to provide a callback to code outside of the
mmu_notifier realms, a place where it is safe to cleanup the
mmu_notifier and associated resources.

Cheers,
J=E9r=F4me Glisse

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
