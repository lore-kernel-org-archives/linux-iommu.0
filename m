From: Graham Neville <grahamneville-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: AMD Ryzen KVM/NPT/IOMMU issue
Date: Wed, 28 Jun 2017 19:17:48 +0000
Message-ID: <CAEk7i18UpswR4F3u_39DQdpNdkSR8jQFDLeQa8A9KmP=Ho3ROQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2037566087674925982=="
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

--===============2037566087674925982==
Content-Type: multipart/alternative; boundary="001a113d255023ed0a05530a0a11"

--001a113d255023ed0a05530a0a11
Content-Type: text/plain; charset="UTF-8"

Although not related to graphics card performance, there is definitely
another issue with regards to running KVM nested L2 guests when npt=1.

Thought I'd mention this in case it helps with identifying performance
issues with NPT.

I'm unable to start any L2 guests with KVM acceleration (--enable-kvm). As
soon as it attempts to bring up the L2 guest the L1 host crashes, L0 host
remains online. Nothing is printed in either L1 or L0's dmesg.

My L0 is running Arch with 4.11.0-rc6, with qemu 2.8.0. I've tried
different L1 hosts (Ubuntu,Arch) and different kernels right to 4.12-rc5
kernel, along with different qemu versions.

This used to work fine with my Intel i7-4770s setup.

With npt=0, L2 guests can start but performance is dier.

--001a113d255023ed0a05530a0a11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Although not related to graphics card performance, th=
ere is definitely another issue with regards to running KVM nested L2=C2=A0=
guests when npt=3D1.</div><div><br></div><div>Thought I&#39;d mention this =
in case it helps with identifying performance issues with NPT.</div><div><b=
r></div><div>I&#39;m unable to start any L2 guests with KVM acceleration (-=
-enable-kvm). As soon as=C2=A0it attempts to bring up the L2 guest the L1 h=
ost crashes, L0 host remains online. Nothing is printed in either L1 or L0&=
#39;s dmesg.</div><div><br></div><div>My L0 is running Arch with 4.11.0-rc6=
, with qemu 2.8.0.=C2=A0I&#39;ve tried different L1 hosts (Ubuntu,Arch) and=
 different kernels right to 4.12-rc5 kernel, along with different qemu vers=
ions.</div><div><br></div><div>This used to work fine with my Intel i7-4770=
s setup.</div><div><br></div><div>With npt=3D0, L2 guests can start but per=
formance is dier.</div></div>

--001a113d255023ed0a05530a0a11--

--===============2037566087674925982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2037566087674925982==--
