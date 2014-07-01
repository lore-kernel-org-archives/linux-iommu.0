From: Jerome Glisse <j.glisse@gmail.com>
Subject: Re: [PATCH 1/6] mmput: use notifier chain to call subsystem exit
 handler.
Date: Tue, 1 Jul 2014 15:33:44 -0400
Message-ID: <20140701193343.GB3322@gmail.com>
References: <1403920822-14488-1-git-send-email-j.glisse@gmail.com>
 <1403920822-14488-2-git-send-email-j.glisse@gmail.com>
 <019CCE693E457142B37B791721487FD91806B836@storexdag01.amd.com>
 <20140630154042.GD26537@8bytes.org>
 <20140630160604.GF1956@gmail.com>
 <20140630181623.GE26537@8bytes.org>
 <20140630183556.GB3280@gmail.com>
 <20140701091535.GF26537@8bytes.org>
 <019CCE693E457142B37B791721487FD91806DD8B@storexdag01.amd.com>
 <20140701110018.GH26537@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20140701110018.GH26537@8bytes.org>
Sender: owner-linux-mm@kvack.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Gabbay, Oded" <Oded.Gabbay@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lewycky, Andrew" <Andrew.Lewycky@amd.com>, "Cornwall, Jay" <Jay.Cornwall@amd.com>, "Bridgman, John" <John.Bridgman@amd.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mgorman@suse.de" <mgorman@suse.de>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infraread.org" <peterz@infraread.org>, "aarcange@redhat.com" <aarcange@redhat.com>, "riel@redhat.com" <riel@redhat.com>, "jweiner@redhat.com" <jweiner@redhat.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, Mark Hairgrove <mhairgrove@nvidia.com>, Jatin Kumar <jakumar@nvidia.com>, Subhash Gutti <sgutti@nvidia.com>, Lucien Dunning <ldunning@nvidia.com>, Cameron Buschardt <cabuschardt@nvidia.com>, Ar
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 01, 2014 at 01:00:18PM +0200, Joerg Roedel wrote:
> On Tue, Jul 01, 2014 at 09:29:49AM +0000, Gabbay, Oded wrote:
> > In the KFD, we need to maintain a notion of each compute process.
> > Therefore, we have an object called "kfd_process" that is created for
> > each process that uses the KFD. Naturally, we need to be able to trac=
k
> > the process's shutdown in order to perform cleanup of the resources i=
t
> > uses (compute queues, virtual address space, gpu local memory
> > allocations, etc.).
>=20
> If it is only that, you can also use the task_exit notifier already in
> the kernel.

No task_exit will happen per thread not once per mm.

>=20
> > To enable this tracking mechanism, we decided to associate the
> > kfd_process with mm_struct to ensure that a kfd_process object has
> > exactly the same lifespan as the process it represents. We preferred =
to
> > use the mm_struct and not a file description because using a file
> > descriptor to track =E2=80=9Cprocess=E2=80=9D shutdown is wrong in tw=
o ways:
> >=20
> > * Technical: file descriptors can be passed to unrelated processes us=
ing
> > AF_UNIX sockets. This means that a process can exit while the file st=
ays
> > open. Even if we implement this =E2=80=9Ccorrectly=E2=80=9D i.e. hold=
ing the address
> > space & page tables alive until the file is finally released, it=E2=80=
=99s
> > really dodgy.
>=20
> No, its not in this case. The file descriptor is used to connect a
> process address space with a device context. Thus without the mappings
> the file-descriptor is useless and the mappings should stay in-tact
> until the fd is closed.
>=20
> It would be a very bad semantic for userspace if a fd that is passed on
> fails on the other side because the sending process died.
>=20

Consider use case where there is no file associated with the mmu_notifier
ie there is no device file descriptor that could hold and take care of
mmu_notifier destruction and cleanup. We need this call chain for this
case.

Anyother idea than task_exit ?

Cheers,
J=C3=A9r=C3=B4me

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
