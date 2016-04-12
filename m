From: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFT v2] iommu/amd: use subsys_initcall() on amdv2 iommu
Date: Wed, 13 Apr 2016 00:07:15 +0200
Message-ID: <20160412220715.GL1990@wotan.suse.de>
References: <20160316171719.GE2195@8bytes.org>
	<1459273313-5139-1-git-send-email-mcgrof@kernel.org>
	<CAB=NE6XCmMk4sraQo34XQJfjWu_yRc1rar_eQRSET8Q7VR9EOw@mail.gmail.com>
	<570BA694.8040900@amd.com>
	<CAFCwf10oD9c3MOW3+J8A5MVjVkX0nNRGCEE2pWcQxOy7mjUsBw@mail.gmail.com>
	<570BAC2B.4090508@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <570BAC2B.4090508-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 11, 2016 at 03:52:43PM +0200, Christian K=F6nig wrote:
> Am 11.04.2016 um 15:39 schrieb Oded Gabbay:
> >On Mon, Apr 11, 2016 at 4:28 PM, Christian K=F6nig
> ><christian.koenig-5C7GfCeVMHo@public.gmane.org> wrote:
> >>Am 09.04.2016 um 02:25 schrieb Luis R. Rodriguez:
> >>>On Tue, Mar 29, 2016 at 10:41 AM, Luis R. Rodriguez <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org=
> wrote:
> >>>>We need to ensure amd iommu v2 initializes before
> >>>>driver uses such as drivers/gpu/drm/amd/amdkfd/kfd_module.c,
> >>>>to do this make its init routine a subsys_initcall() which
> >>>>ensures its load init is called first than modules when
> >>>>built-in.
> >>>>
> >>>>This reverts the old work around implemented through commit
> >>>>1bacc894c227fad8a7 ("drivers: Move iommu/ before gpu/ in Makefile"),
> >>>>instead of making the dependency implicit by linker order this
> >>>>makes the ordering requirement explicit through proper kernel
> >>>>APIs.
> >>>>
> >>>>Cc: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
> >>>>Cc: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >>>>Signed-off-by: Luis R. Rodriguez <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >>
> >>Sorry for not responding earlier. Just coming back to all the stuff on =
my TODO list.
> >>
> >>Patch is Acked-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >
> >Christian,
> >Just wanted to be sure if you tested this patch-set or not.
> =

> I did NOT tested it. If AMD IOMMU requires something which will now
> initialize after the IOMMU module we will obviously run into trouble
> again.
> =

> I assumed that the creator of the patch did some testing.

Nope, hence [RTF] Request For Testing.

> >I don't think it should be merged without testing. If you already
> >tested it than fine. If not, I think I can do it in the next week or
> >so (just came back from PTO).
> =

> Yeah, agree totally.

Agreed, please let me know if someone is able to test and confirm
this works. It should work.

  Luis
