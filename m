From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC PATCH v2 6/7] arm: call iommu_init before
	of_platform_populate
Date: Tue, 02 Sep 2014 20:13:46 +0200
Message-ID: <6406734.5D2q2gd403@wuerfel>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
	<1409680587-29818-7-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409680587-29818-7-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tuesday 02 September 2014 18:56:26 Will Deacon wrote:
> @@ -803,9 +804,11 @@ static int __init customize_machine(void)
>         if (machine_desc->init_machine)
>                 machine_desc->init_machine();
>  #ifdef CONFIG_OF
> -       else
> +       else {
> +               of_iommu_init();
>                 of_platform_populate(NULL, of_default_bus_match_table,
>                                         NULL, NULL);
> +       }
>  #endif
>         return 0;
>  }

I think it would be better to not have this depend on the presence
of an init_machine callback. Why not move of_iommu_init() in front
of the if()? It shouldn't do anything unless we have an iommu
driver that we should be using.

	Arnd
