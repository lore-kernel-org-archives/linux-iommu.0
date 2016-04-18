From: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFT v2] iommu/amd: use subsys_initcall() on amdv2 iommu
Date: Mon, 18 Apr 2016 14:03:50 +0200
Message-ID: <20160418120350.GE1990@wotan.suse.de>
References: <20160316171719.GE2195@8bytes.org>
	<1459273313-5139-1-git-send-email-mcgrof@kernel.org>
	<CAB=NE6XCmMk4sraQo34XQJfjWu_yRc1rar_eQRSET8Q7VR9EOw@mail.gmail.com>
	<570BA694.8040900@amd.com>
	<CAFCwf10oD9c3MOW3+J8A5MVjVkX0nNRGCEE2pWcQxOy7mjUsBw@mail.gmail.com>
	<570BAC2B.4090508@amd.com> <20160412220715.GL1990@wotan.suse.de>
	<CAFCwf12SJ-dTv6PC0_KfHbtC9951xb_4v8wu5uSjXO-V3TgdkA@mail.gmail.com>
	<CAB=NE6WL7j_azrFxQUG3bybXtu67ew51CyzYvkBct6tCdARKDg@mail.gmail.com>
	<CAFCwf12B6TQ5kYEG4+hYoWriv2rnTcngQLX_Cvtbz=64fo35Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFCwf12B6TQ5kYEG4+hYoWriv2rnTcngQLX_Cvtbz=64fo35Qg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 18, 2016 at 10:02:24AM +0300, Oded Gabbay wrote:
> On Mon, Apr 18, 2016 at 9:55 AM, Luis R. Rodriguez <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wr=
ote:
> >
> > On Apr 18, 2016 7:48 AM, "Oded Gabbay" <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>
> >> On Wed, Apr 13, 2016 at 1:07 AM, Luis R. Rodriguez <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >> wrote:
> >> > On Mon, Apr 11, 2016 at 03:52:43PM +0200, Christian K=F6nig wrote:
> >> >> Am 11.04.2016 um 15:39 schrieb Oded Gabbay:
> >> >> >On Mon, Apr 11, 2016 at 4:28 PM, Christian K=F6nig
> >> >> ><christian.koenig-5C7GfCeVMHo@public.gmane.org> wrote:
> >> >> >>Am 09.04.2016 um 02:25 schrieb Luis R. Rodriguez:
> >> >> >>>On Tue, Mar 29, 2016 at 10:41 AM, Luis R. Rodriguez
> >> >> >>> <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >> >> >>>>We need to ensure amd iommu v2 initializes before
> >> >> >>>>driver uses such as drivers/gpu/drm/amd/amdkfd/kfd_module.c,
> >> >> >>>>to do this make its init routine a subsys_initcall() which
> >> >> >>>>ensures its load init is called first than modules when
> >> >> >>>>built-in.
> >> >> >>>>
> >> >> >>>>This reverts the old work around implemented through commit
> >> >> >>>>1bacc894c227fad8a7 ("drivers: Move iommu/ before gpu/ in
> >> >> >>>> Makefile"),
> >> >> >>>>instead of making the dependency implicit by linker order this
> >> >> >>>>makes the ordering requirement explicit through proper kernel
> >> >> >>>>APIs.
> >> >> >>>>
> >> >> >>>>Cc: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
> >> >> >>>>Cc: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >> >> >>>>Signed-off-by: Luis R. Rodriguez <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >> >> >>
> >> >> >>Sorry for not responding earlier. Just coming back to all the stu=
ff
> >> >> >> on my TODO list.
> >> >> >>
> >> >> >>Patch is Acked-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >> >> >
> >> >> >Christian,
> >> >> >Just wanted to be sure if you tested this patch-set or not.
> >> >>
> >> >> I did NOT tested it. If AMD IOMMU requires something which will now
> >> >> initialize after the IOMMU module we will obviously run into trouble
> >> >> again.
> >> >>
> >> >> I assumed that the creator of the patch did some testing.
> >> >
> >> > Nope, hence [RTF] Request For Testing.
> >> >
> >> >> >I don't think it should be merged without testing. If you already
> >> >> >tested it than fine. If not, I think I can do it in the next week =
or
> >> >> >so (just came back from PTO).
> >> >>
> >> >> Yeah, agree totally.
> >> >
> >> > Agreed, please let me know if someone is able to test and confirm
> >> > this works. It should work.
> >> >
> >> >   Luis
> >>
> >> Hi,
> >> So I finally got to test this patch and it's not working.
> >> The reason is that AMD IOMMUv2 gets initialized *before* AMD IOMMUv1
> >> driver !
> >
> > Thanks can you try using late_initcall() instead then?
> >
> >   Luis
> =

> That will make it initialize *after* drm subsystem, which will cause
> another bug.

Hold up, I thought that we needed AMD IOMMUv2 to get initialized
before AMD IOMMUv1 ? That's what the patch did. Can someone clarify
the requirements then?

I'll provide some review of the current state of affairs first, without the
patch. AMD IOMMUv1 uses x86_init.iommu.iommu_init and that has its own init
semantics. Specifically that gets called via pci_iommu_init() which is pegg=
ed
on the init order via rootfs_initcall(pci_iommu_init);

Then AMD IOMMUv2 uses module_init() and that when is built-in falls on to
__initcall() which is device_initcall().

The order is:

#define pure_initcall(fn)               __define_initcall(fn, 0)           =
     =

                                                                           =
     =

#define core_initcall(fn)               __define_initcall(fn, 1)           =
     =

#define core_initcall_sync(fn)          __define_initcall(fn, 1s)          =
     =

#define postcore_initcall(fn)           __define_initcall(fn, 2)           =
     =

#define postcore_initcall_sync(fn)      __define_initcall(fn, 2s)          =
     =

#define arch_initcall(fn)               __define_initcall(fn, 3)           =
     =

#define arch_initcall_sync(fn)          __define_initcall(fn, 3s)          =
     =

#define subsys_initcall(fn)             __define_initcall(fn, 4)           =
     =

#define subsys_initcall_sync(fn)        __define_initcall(fn, 4s)          =
     =

#define fs_initcall(fn)                 __define_initcall(fn, 5)           =
     =

#define fs_initcall_sync(fn)            __define_initcall(fn, 5s)          =
     =

#define rootfs_initcall(fn)             __define_initcall(fn, rootfs)      =
     =

#define device_initcall(fn)             __define_initcall(fn, 6)           =
     =

#define device_initcall_sync(fn)        __define_initcall(fn, 6s)          =
     =

#define late_initcall(fn)               __define_initcall(fn, 7)           =
     =

#define late_initcall_sync(fn)          __define_initcall(fn, 7s)          =


So technically rootfs_initcall() (v1 amd) should be being called
first already, and after that AMD IOMMUv2 gets called next.

You said that with my patch you saw AMD IOMMUv2 kick off first,
that was intentional as I thought that's what you needed. Can
someone please describe the requirements?

Also what does drm use that you say has a conflict already? What
drm code are we talking about exactly ?

  Luis
