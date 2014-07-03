From: Jerome Glisse <j.glisse@gmail.com>
Subject: Re: [PATCH 1/6] mmput: use notifier chain to call subsystem exit
 handler.
Date: Thu, 3 Jul 2014 14:30:26 -0400
Message-ID: <20140703183024.GA3306@gmail.com>
References: <20140630154042.GD26537@8bytes.org>
 <20140630160604.GF1956@gmail.com>
 <20140630181623.GE26537@8bytes.org>
 <20140630183556.GB3280@gmail.com>
 <20140701091535.GF26537@8bytes.org>
 <019CCE693E457142B37B791721487FD91806DD8B@storexdag01.amd.com>
 <20140701110018.GH26537@8bytes.org>
 <20140701193343.GB3322@gmail.com>
 <20140701210620.GL26537@8bytes.org>
 <20140701213208.GC3322@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20140701213208.GC3322@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Gabbay, Oded" <Oded.Gabbay@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lewycky, Andrew" <Andrew.Lewycky@amd.com>, "Cornwall, Jay" <Jay.Cornwall@amd.com>, "Bridgman, John" <John.Bridgman@amd.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mgorman@suse.de" <mgorman@suse.de>, "hpa@zytor.com" <hpa@zytor.com>, peterz@infradead.org, "aarcange@redhat.com" <aarcange@redhat.com>, "riel@redhat.com" <riel@redhat.com>, "jweiner@redhat.com" <jweiner@redhat.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, Mark Hairgrove <mhairgrove@nvidia.com>, Jatin Kumar <jakumar@nvidia.com>, Subhash Gutti <sgutti@nvidia.com>, Lucien Dunning <ldunning@nvidia.com>, Cameron Buschardt <cabuschardt@nvidia.com>, Arvind Gopalakrishnan <arvin>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 01, 2014 at 05:32:09PM -0400, Jerome Glisse wrote:
> On Tue, Jul 01, 2014 at 11:06:20PM +0200, Joerg Roedel wrote:
> > On Tue, Jul 01, 2014 at 03:33:44PM -0400, Jerome Glisse wrote:
> > > On Tue, Jul 01, 2014 at 01:00:18PM +0200, Joerg Roedel wrote:
> > > > No, its not in this case. The file descriptor is used to connect =
a
> > > > process address space with a device context. Thus without the map=
pings
> > > > the file-descriptor is useless and the mappings should stay in-ta=
ct
> > > > until the fd is closed.
> > > >=20
> > > > It would be a very bad semantic for userspace if a fd that is pas=
sed on
> > > > fails on the other side because the sending process died.
> > >=20
> > > Consider use case where there is no file associated with the mmu_no=
tifier
> > > ie there is no device file descriptor that could hold and take care=
 of
> > > mmu_notifier destruction and cleanup. We need this call chain for t=
his
> > > case.
> >=20
> > Example of such a use-case where no fd will be associated?
> >=20
> > Anyway, even without an fd, there will always be something that sets =
the
> > mm->device binding up (calling mmu_notifier_register) and tears it do=
wn
> > in the end (calling mmu_notifier_unregister). And this will be the
> > places where any resources left from the .release call-back can be
> > cleaned up.
> >=20
>=20
> That's the whole point we can not do what we want without the callback =
ie
> the place where we do the cleanup is the mm callback we need. If you do=
 not
> like the call chain than we will just add ourself as another caller in =
the
> exact same spot where the notifier chain is which Andrew disliked becau=
se
> there are already enough submodule that are interested in being inform =
of
> mm destruction.
>=20
> Cheers,
> J=E9r=F4me

Joerg do you still object to this patch ? Knowing that we need to bind th=
e
lifetime of our object with the mm_struct. While the release callback of
mmu_notifier allow us to stop any further processing in timely manner wit=
h
mm destruction, we can not however free some of the associated resources
namely the structure containing the mmu_notifier struct. We could schedul=
e
a delayed job to do it sometimes after we get the release callback but th=
at
would be hackish.

Again the natural place to call this is from mmput and the fact that many
other subsystem already call in from there to cleanup there own per mm da=
ta
structure is a testimony that this is a valid use case and valid design.

This patch realy just try to allow new user to easily interface themself
at proper place in mm lifetime. It is just as the task exit notifier chai=
n
but i deals with the mm_struct.

You pointed out that the cleanup should be done from the device driver fi=
le
close call. But as i stressed some of the new user will not necessarily h=
ave
a device file open hence no way for them to free the associated structure
except with hackish delayed job.

So i do not see any reasons to block this patch.

Cheers,
J=E9r=F4me

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
