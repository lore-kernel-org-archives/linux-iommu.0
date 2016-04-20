From: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Subject: Re: [PATCH v4 5/7] iommu/vt-d: avoid dev iotlb logic in intel-iommu
	for domains with no dev iotlbs
Date: Wed, 20 Apr 2016 18:36:20 +0300
Message-ID: <CAHMfzJnFk2VRr9ejpjPLAbW=9dqM0DjURowTt7=yyVWjs58qEQ@mail.gmail.com>
References: <cover.1461135861.git.mad@cs.technion.ac.il>
	<3780bc5682714a48a8d90ee0adf621dbd3529283.1461135861.git.mad@cs.technion.ac.il>
	<CANSfodEQC3YcVh0_THpDMQx_YZqD=p5Zw5BEnwRhm3hNgaLOhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CANSfodEQC3YcVh0_THpDMQx_YZqD=p5Zw5BEnwRhm3hNgaLOhA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Godfrey van der Linden <gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Tsafrir <dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>, Kernel-team-b10kYP2dOMg@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 20, 2016 at 6:17 PM, Godfrey van der Linden <gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> Adam you mention in the 0/7 description that you have moved the location of
> has_iotlb_device which is a good idea.
>
> This patch did not move it after all, it is identical to the v3 version.

Ouch, not sure how that happened.  I'll repost patch 5/7.
