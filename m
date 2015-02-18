From: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: SMMU 2-stage support
Date: Wed, 18 Feb 2015 18:04:21 +0100
Message-ID: <CAN9JPjFf1Lb+L8sWq0SWt8f6P6DX2i308OeF+TdnFdstRoU3hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1766979127736853145=="
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
To: Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============1766979127736853145==
Content-Type: multipart/alternative; boundary=001a11c081fe7fc2e4050f5fcf99

--001a11c081fe7fc2e4050f5fcf99
Content-Type: text/plain; charset=UTF-8

We are currently working on the ARM SMMU 2-stage support in order to expose
SMMU capabilities to a guest OS.
By doing some research, we noticed some work has already be done by Will
Deacon on exposing virtual IOMMU interface to KVM guest. After going
through slides and code (on git://
git.kernel.org/pub/scm/linux/kernel/git/will/linux.git, branch:
iommu/vsmmu), we have some questions :

- What is the status of this work ? Is Alex still working on it ?
- Are there any test case about the current vsmmu implementation ?

- What is exposed to the guest in the current implementation ?
- How do the guest program the stage-1 translation ?

Thanks for your consideration,
Baptiste

--001a11c081fe7fc2e4050f5fcf99
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">We are currently working on the ARM SMMU 2-stage support i=
n order to expose SMMU capabilities to a guest OS. <br>By
 doing some research, we noticed some work has already be done by Will=20
Deacon on exposing virtual IOMMU interface to KVM guest. After going=20
through slides and code (on git://<a href=3D"http://git.kernel.org/pub/scm/=
linux/kernel/git/will/linux.git" target=3D"_blank">git.kernel.org/pub/scm/l=
inux/kernel/git/will/linux.git</a>,
    branch: iommu/vsmmu), we have some questions :<br><br>- What is the sta=
tus of this work ? Is Alex still working on it ?<br>- Are there any test ca=
se about the current vsmmu implementation ?<br><br>- What is exposed to the=
 guest in the current implementation ?<br>- How do the guest program the st=
age-1 translation ?<div><br></div>Thanks for your consideration,<br>Baptist=
e</div>

--001a11c081fe7fc2e4050f5fcf99--

--===============1766979127736853145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1766979127736853145==--
