From: geoff--- via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: AMD Ryzen KVM/NPT/IOMMU issue
Date: Tue, 24 Oct 2017 10:49:36 +1100
Message-ID: <b88fc14b230d7ecac6066bdd9e95be19@hostfission.com>
Reply-To: geoff-9M2dFRIgpjGrDvn5mFPilA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
List-Id: iommu@lists.linux-foundation.org

Hi,

I realize this is an older thread but I have spent much of today trying 
to
diagnose the problem.

I have discovered how to reliably reproduce the problem with very little 
effort.
It seems that reproducing the issue has been hit and miss for people as 
it seems
to primarily affect games/programs that make use of nVidia PhysX. My
understanding of npt's inner workings is quite primitive but I have 
still spent
much of my time trying to diagnose the fault and identify the cause.

Using the free program FluidMark[1] it is possible to reproduce the 
issue, where
on a GTX 1080Ti the rendering rate drops to around 4 fps with npt turned 
on, but
if turned off the render rate is in excess of 60fps.

I have produced traces for with and without ntp enabled during these 
tests which
I can provide if it will help. So far I have been digging through how 
npt works
and trying to glean as much information as I can from the source and the 
AMD
specifications but much of this and how mmu works is very new to me so 
progress
is slow.

If anyone else has looked into this and has more information to share I 
would be
very interested.

Kind Regards,
Geoffrey McRae
HostFission
https://hostfission.com


[1]: 
http://www.geeks3d.com/20130308/fluidmark-1-5-1-physx-benchmark-fluid-sph-simulation-opengl-download/
