From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] iommu/vt-d: Fix broken device issue when using iommu=pt
Date: Fri, 5 Sep 2014 09:11:28 +0800
Message-ID: <54090DC0.9040309@huawei.com>
References: <1408949099-18677-1-git-send-email-wangyijing@huawei.com>
	<20140825091531.GG16329@8bytes.org>
	<8dada92a-19af-4b77-b917-f2d97291abbe@CMEXHTCAS2.ad.emulex.com>
	<53FB1B09.5070209@huawei.com>
	<8b3c2f14-d454-45f5-87ab-69e1b87f27c9@CMEXHTCAS1.ad.emulex.com>
	<53FB3048.90601@huawei.com>
	<ff926f1d-b899-4245-93bf-3aa1b593ad7e@CMEXHTCAS1.ad.emulex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <ff926f1d-b899-4245-93bf-3aa1b593ad7e-3RiH6ntJJkP8BX6JNMqfyFjyZtpTMMwT@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sathya Perla <Sathya.Perla-iH1Dq9VlAzfQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Sarveswara Rao Mygapula <SarveswaraRao.Mygapula-iH1Dq9VlAzfQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Subramanian Seetharaman <subbu.seetharaman-laKkSmNT4hbQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

>>> Could you also please send the me the FW version (output of "ethtool -i
>> eth0")
>>
>> Hi Sathya, thanks for your help. FW version is 4.6.247.5   driver version is
>> 4.4.161.0s
> 
> Hi Wang, this issue (a FW bug) was fixed in the 4.9 FW series. 
> The HP qualified FW (ver 4.9.416.0) is available at 
> 
> http://h20565.www2.hp.com/portal/site/hpsc/template.PAGE/public/psi/swdDetails/?sp4ts.oid=4324790&spf_p.tpst=swdMain&spf_p.prp_swdMain=wsrp-navigationalState%3Didx%253D%257CswItem%253Dco_131997_1%257CswEnvOID%253D54%257CitemLocale%253D%257CswLang%253D%257Cmode%253D%257Caction%253DdriverDocument&javax.portlet.begCacheTok=com.vignette.cachetoken&javax.portlet.endCacheTok=com.vignette.cachetoken
> 
> Could you please upgrade your adapter FW and verify the issue.

That's great! Thank you very much. I will notify my colleague to test it. Because this machine is not in my hand, so
it may take some time.

Thanks!
Yijing.

> 
> thanks,
> -Sathya
> 
> .
> 


-- 
Thanks!
Yijing
