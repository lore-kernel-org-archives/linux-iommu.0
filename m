From: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Subject: Re: [PATCH 2/7] iommu: per-cpu deferred invalidation queues
Date: Wed, 13 Apr 2016 14:32:38 +0300
Message-ID: <CAHMfzJnfw_cAJHxxPS0dF1qboGcjU_ZAvEotGmd+xnRXgWNmfA@mail.gmail.com>
References: <20151228161603.GA27859@cs.technion.ac.il>
	<CAN+hb0Wrzfyp7b9iE-FqcMhR+kP+Aq=OJDF8LkVKJb_jOGVaBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAN+hb0Wrzfyp7b9iE-FqcMhR+kP+Aq=OJDF8LkVKJb_jOGVaBQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Dan Tsafrir <dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 11, 2016 at 11:10 PM, Benjamin Serebrin via iommu
<iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org> wrote:
> Reviewed-by: Ben Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
>
> Commit message nit: s/defererred/deferred/
>
> intel-iommu.c Line 3615: I'd suggest making the 10ms into a #defined constant.

This should probably be done in an independent patch for cleanups.  I
don't like "sneaking in" cleanups when making functional changes.
