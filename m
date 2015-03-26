From: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: IOMMU and domain binding/unbinding logic
Date: Thu, 26 Mar 2015 12:50:47 -0400
Message-ID: <20150326165046.GA2965@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

I was looking at IOMMUv2 and AMD APU kfd driver registration and initializa=
tion
(drivers/gpu/drm/amd/amdkfd/kfd_device.c). I am left puzzle with 2 things.

General IOMMU question, my understanding is that each device is associated =
with
one domain only (ignoring device that have several alias if such thing exis=
t).
So i would assume that when some one wants to attach a new domain to a devi=
ce
it would fail if the device is already attached to a domain (other than the
passthrough domain or some common dma domain). But i fail to see anywhere in
the code for such test (wether in drivers/iommu/iommu.c or in any iommu dri=
ver
code). On contrary if i look at driver code the first thing it does in the
attach callback is unbind the currently bound domain.

So if there are some active DMA mapping in current bound domain they are lo=
st
and even worst once the driver call the dma_unmap api it will possibly free
new unrelated mapping. Which sounds really buggy.

Of course there are very few user of the iommu api, mostly for virtualizati=
on
and AMD kfd driver. In virtualization case i think the passthrough implicit=
ly
force that no host driver are bound to the device and hence no domain. So no
issue there AFAICT.

In the kfd driver things are different, kfd driver initialization happens
after GPU driver initialization (drivers/gpu/drm/radeon/radeon_kms.c look
for radeon_kfd_device_probe() radeon_kfd_device_init()). At this point the
GPU driver already allocated a bunch of memory and mapped it through the
pci_map_page() (which endup in dma_map_page()). So assuming we are not in
passthrough there are live and working/in use mapping.

Now the issue is that kfd call amd_iommu_init_device() which allocates a
new iommu domain and replace currently bound domain with it. This new
domain is however different from previously (default domain) in that it
does not have PD_DMA_OPS_MASK domain flags set and as such if i am reading
code properly will lead to all dma_map_page() to fail (or any other dma-op
for that matter).

So how comes it still looks like it is working properly ? My best guest
it is because it is by default in passthrough, but i haven't checked that
theory.


I am sure i am missing something very obvious somewhere in the code but
after spending couple hour staring at it, it is still eluding me.

Cheers,
J=E9r=F4me
