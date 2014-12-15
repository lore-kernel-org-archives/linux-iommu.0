From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/3] Add support for APM X-Gene SoC AHBC IOMMU driver.
Date: Mon, 15 Dec 2014 21:27:39 +0100
Message-ID: <20141215202738.GG24292@8bytes.org>
References: <1418662523-8458-1-git-send-email-stripathi@apm.com>
	<548F3C91.3030803@redhat.com>
	<CAOHikRB0eBnPnE+QWdmWunOMFHJOLDqU6o2ByBruQ3KC+1-XmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOHikRB0eBnPnE+QWdmWunOMFHJOLDqU6o2ByBruQ3KC+1-XmA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Suman,

On Tue, Dec 16, 2014 at 01:31:58AM +0530, Suman Tripathi wrote:
> On Dec 16, 2014 1:25 AM, "Don Dutile" <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> =

>     On 12/15/2014 11:55 AM, Suman Tripathi wrote:
> =

>         This patch adds the support for the APM X-Gene SoC AHBC IOMMU dri=
ver.
> =

>         Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
>         ---
> =

>         Suman Tripathi (3):
>         =A0 =A0xgene-ahbc-iommu: Add support for APM X-Gene SoC AHBC IOMM=
U driver.
>         =A0 =A0arm64: dts: Add the APM X-Gene AHBC IOMMU DTS node.
>         =A0 =A0Documentation: dt-bindings: Add the binding info for APM X=
-Gene AHBC
>         =A0 =A0 =A0IOMMU driver.
> =

>         =A0 .../devicetree/bindings/iommu/xgene,ahbc-iommu.txt |=A0 17 ++
>         =A0 arch/arm64/boot/dts/apm-storm.dtsi=A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0|=A0 =A05 +
>         =A0 drivers/iommu/Kconfig=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 |=A0 10 +
>         =A0 drivers/iommu/Makefile=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0|=A0 =A01 +
>         =A0 drivers/iommu/xgene-ahbc-iommu.c=A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| 336
>         +++++++++++++++++++++
>         =A0 5 files changed, 369 insertions(+)
>         =A0 create mode 100644 Documentation/devicetree/bindings/iommu/
>         xgene,ahbc-iommu.txt
>         =A0 create mode 100644 drivers/iommu/xgene-ahbc-iommu.c

What are the differences between the X-Gene IOMMU and the ARM-SMMU?


	Joerg
