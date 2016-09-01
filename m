From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 00/19] Generic DT bindings for PCI IOMMUs and ARM SMMU
Date: Thu, 1 Sep 2016 11:10:38 +0100
Message-ID: <18cc3892-5735-10a2-bd45-7e5087329d51@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
	<3a9a9369-d8cd-66f4-9344-965c80894bb6@arm.com>
	<CAALAos-OzPG=+aU8eKEZtx6EFXytPXq09k3QweHvtYCD=mN0mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAALAos-OzPG=+aU8eKEZtx6EFXytPXq09k3QweHvtYCD=mN0mQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Device Tree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 01/09/16 04:49, Anup Patel wrote:
> Hi Robin,
> 
> What are the chances of having this series in Linux-4.9?

Well, I'm planning to do everything I can over the next few weeks to
make that happen, but ultimately it's down to maintainers, not me ;)

I'll certainly be posting a v6 next week to address the feedback so far,
but the more people who can find time to give it a proper review
(particularly, say, in terms of systems with funky PCI topology) the better!

Robin.

> 
> Regards,
> Anup
> 
